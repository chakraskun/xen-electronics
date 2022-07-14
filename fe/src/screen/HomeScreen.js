import axios from "axios";
import { useEffect, useState } from 'react';
import { Card, Modal, Select, Button, Row, Col } from 'antd';
import { BarsOutlined } from '@ant-design/icons';
import LoadingBox from '../components/LoadingBox';
import MessageBox from '../components/MessageBox';
import ModalScreen from '../screen/ModalScreen';
import styled from 'styled-components';
import Cookies from "js-cookie";
import { useNavigate } from "react-router-dom";

const StyledCard = styled(Card)`
  .ant-card-meta-title {
    font-size: 20px;
    font-weight: bold;
  }
`;

export default function HomeScreen() {
  const [ products, setProducts ] = useState([]);
  const [ categories, setCategories ] = useState([]);
  const [ modalData, setModaldata ] = useState([]);
  const [ totalItemInCarts, setTotalItemInCarts ] = useState(0);
  const [ totalPrice, setTotalPrice ] = useState(0);

  const { Meta } = Card;

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  const [isModalVisible, setIsModalVisible] = useState(false);
  const navigate = useNavigate();

  useEffect(()=> {
    fetchData();
    fetchCart();
    fetchCategories();
  }, []);

  const { Option } = Select;
  let token = null

  //check cookies
  if (Cookies.get('token')) {
    token = Cookies.get('token');
  } else {
    navigate('/signin');
  }

  const showModal = () => {
    fetchCart();
    console.log(modalData)
    setIsModalVisible(true);
  };

  const handleCheckout = async () => {
    try {
      const response = await axios.delete( process.env.REACT_APP_API_URL + '/api/carts/checkout', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      if (response.data.status === "OK") {
        setIsModalVisible(false);
        fetchCart();
      }
    } catch (err) {
      setError(true);
    }
  };

  const handleCancel = () => {
    setIsModalVisible(false);
  };

  const fetchData = async () => {
    try {
      const response = await axios.get( process.env.REACT_APP_API_URL + '/api/products', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      }); 
      setProducts(response.data.data.products);
    } catch (error) {
      setError(true);
    }
    setLoading(false);
  }

  const fetchCategories = async () => {
    try {
      const response = await axios.get( process.env.REACT_APP_API_URL + '/api/categories', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      setCategories(response.data.data.categories);
    } catch (error) {
      setError(true);
    }
    setLoading(false);
  }

  const fetchCart = async () => {
    try {
      const response = await axios.get( process.env.REACT_APP_API_URL + '/api/carts', {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      setTotalItemInCarts(response.data.data.cart.length);
      setModaldata(response.data.data.cart.sort((a, b) => a.name - b.name));
      setTotalPrice(response.data.data.total_price);
    } catch (error) {
      setError(true);
    }
    setLoading(false);
  }

  const addToCart = async (id) => {
    try {
      const response = await axios.post(process.env.REACT_APP_API_URL + '/api/carts/add', {
        product_id: id,
        quantity: 1
      }, {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      if (response.data.status === "OK") {
        fetchCart();
      }
    } catch (error) {
      setError(true);
    }
  }

  function titleCase(str) {
    var splitStr = str.toLowerCase().split('_');
    for (var i = 0; i < splitStr.length; i++) {
      splitStr[i] = splitStr[i].charAt(0).toUpperCase() + splitStr[i].substring(1);     
    }
    return splitStr.join(' '); 
  }

  const removeItem = async (id) => {
    try {
      const response = await axios.post( process.env.REACT_APP_API_URL + '/api/carts/deduct', {
        product_id: id,
      }, {
        headers: {
          Authorization: `Bearer ${token}`
        }
      });
      if (response.data.status === "success") {
        fetchCart();
      }
    } catch (error) {
      fetchCart()
      setError(true);
    }
  }

  const handleChangeCategories = async (value) => {
    try {
      const response = await axios.get( process.env.REACT_APP_API_URL + '/api/products', {
        headers: {
          Authorization: `Bearer ${token}`
        }, params: {
          category_id: value
        }
      });
      setProducts(response.data.data.products);
    } catch (error) {
      setError(true);
    }
    setLoading(false);
  }

  function addComma(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

  return (
    <div>
      <Row className="d-flex flex-wrap justify-content-center px-13">
        <Col span={8}>
          <Select
            showSearch
            style={{ width: 200 }}
            placeholder="Select a category"
            onChange={(value) => {
              handleChangeCategories(value);
            }}
          >
            <Option value="">All</Option>
            {categories && categories.map((i) => {
              return (
                <Option value={i.id}>{titleCase(i.name)}</Option>
              )
            })}
          </Select>
        </Col>
        <Col className="justify-content-end" span={8} offset={8}>
          <Button
            type="primary"
            className="ml-2"
            onClick={() => {
              showModal();
            }}
            style={{ float: "right" }}
          >
            My Cart ({totalItemInCarts})
          </Button>
        </Col>
      </Row>
      <div className="site-layout-content d-flex flex-wrap justify-content-center">
        <Modal
          title="Cart Detail"
          visible={isModalVisible}
          onOk={handleCheckout}
          onCancel={handleCancel}
          okText="Checkout"
        >
          <ModalScreen
            dataProduct={modalData}
            dataTotalPrice={totalPrice}
            fetchCart={fetchCart}
            removeItem={removeItem}
            addItem={addToCart}
            isLoading={loading}
          />
        </Modal>
        {loading? <LoadingBox></LoadingBox>
          :
          error?<MessageBox>{error}</MessageBox>
          :<>
          {products.map((product, index) => (
            <div className="d-flex" key={product?.id}>
              <div className='d-flex'>
                <StyledCard
                  hoverable
                  cover={<img alt="example" src={product.image_url} height="200px"/>}
                  style={{
                    width: 280,
                    margin: '5px 5px',
                    borderRadius: "15px",
                    overflow: "hidden"
                  }}
                  >
                  <Meta
                    title={[product.name]}
                    description={product.price_currency + ' ' + addComma(product.price_cents)}
                    style={{
                      fontSize: "15px",
                      fontWeight: "bold",
                      color: "black"
                    }}
                  />
                  <div className="card_body mt-8 ml-2">
                    <div className="d-flex flex-column flex-wrap text-break">
                      <div className="d-flex align-items-center text-muted">
                        <BarsOutlined />
                        <p className="mb-0 ml-3">{titleCase(product.category.name)}</p>
                      </div>
                    </div>
                  </div>
                  <div className="card_footer mt-auto pt-5">
                    <div className="d-flex justify-content-center">
                      <div className="d-flex align-items-center">
                      <Button
                        onClick={() => addToCart(product.id)}
                        style={{
                          borderRadius: "15px",
                          backgroundColor: "#12883D",
                          color: "white",
                          float: "center",
                          border: "none",
                        }}
                      >
                        Add To Cart
                      </Button>
                      </div>
                    </div>
                  </div>
                </StyledCard>
              </div>
            </div>
          ))}
        </>}
      </div>
    </div>
  )
}
