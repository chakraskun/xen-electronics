import React, { Component }  from 'react';
import { Row, Col, Button } from 'antd';
import { MinusOutlined, PlusOutlined } from '@ant-design/icons';


export default class ModalScreen extends Component {

  handleRemove = (id) => {
    this.props.removeItem(id);
    this.props.fetchCart();
  }

  handleAdd = (id) => {
    this.props.addItem(id);
    this.props.fetchCart();
  }

  addComma = (num) => {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  }

  render(){
    return(
      <div>
        <>
          <Row >
            {this.props.dataProduct.map((i, index) => (
              <div key={index} className='d-flex flex-wrap'>
                <div key={i.id}>
                  <Row gutter={{ sm: 32 }}>
                    <Col className="gutter-row pb-6 pt-6" span={6}>
                      <div className="gutter-box">
                        <img src={i.product.image_url} alt="product" height="75px" width="75px" />
                      </div>
                    </Col>
                    <Col className="gutter-row pb-6 pt-6" span={10}>
                      <div className="gutter-box">
                        <h2>{i.product.name}</h2>
                        <p>{i.product.description}</p>
                        <h4>{i.product.price_currency} {this.addComma(i.product.price_cents)}</h4>
                      </div>
                    </Col>
                    <Col className="gutter-row pb-6 pt-6" span={8}>
                      <div className="">
                        <h3>Qty:</h3>
                        <div className="d-flex justify-content-between">
                          <Button
                            type="danger"
                            shape="circle"
                            icon={<MinusOutlined />}
                            size="small"
                            onClick={() => {
                              this.handleRemove(i.product_id);
                            }}
                          >
                          </Button>
                          <h4>{i.quantity}</h4>
                          <Button
                            type="primary"
                            shape="circle"
                            icon={<PlusOutlined />}
                            size="small"
                            onClick={() => {
                              this.handleAdd(i.product_id);
                            }}
                          >
                          </Button>
                        </div>
                      </div>
                    </Col>
                  </Row>
                </div>
              </div>
            ))}
          </Row>
          <Row>
            <div className="d-flex justify-content-between">
              <div className="d-flex align-items-center">
                <h4>Total: {this.addComma(this.props.dataTotalPrice.cents)}</h4>
              </div>
            </div>
          </Row>
        </>
    </div>
    )
  }
}
