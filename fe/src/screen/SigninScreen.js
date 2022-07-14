// import 'dotenv/config'
import React, { useState } from 'react';
import axios from 'axios';
import Cookies from 'js-cookie';
import { useNavigate } from "react-router-dom";
import { Form, Input, Button, Row, Col} from 'antd';
import { UserOutlined, LockOutlined } from '@ant-design/icons';


function SigninScreen(props) {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const navigate = useNavigate();

  const submitHandler = async (e) =>{
    try {
      const response = await axios.post( process.env.REACT_APP_API_URL + '/api/auth/login', {
        email,
        password
      })
      if (response.data.status === "OK") {
        Cookies.set('token', response.data.data.token);
        navigate('/');
      }
    } catch (err) {
      console.log(err)
    }
  }

  return <>
    <Row className="d-flex flex-wrap justify-content-center px-13">
      <Col span={{ xs: 24, sm: 24, md: 10, lg: 10 }}>
        <Form
          name="normal_login"
          className="login-form"
          onFinish={submitHandler}
        >
          <Form.Item
            name="username"
            rules={[{ required: true, message: 'Please input your Username!' }]}
          >
            <Input
              prefix={<UserOutlined className="site-form-item-icon" />}
              placeholder="Username"
              onChange={(e) => setEmail(e.target.value)}
            />
          </Form.Item>
          <Form.Item
            name="password"
            rules={[{ required: true, message: 'Please input your Password!' }]}
          >
            <Input
              prefix={<LockOutlined className="site-form-item-icon" />}
              type="password"
              placeholder="Password"
              onChange={(e) => setPassword(e.target.value)}
            />
          </Form.Item>
          <Form.Item>
            <Button type="primary" htmlType="submit" className="login-form-button">
              Log in
            </Button>
          </Form.Item>
        </Form>
      </Col>
    </Row>
    
  </>
}

export default SigninScreen;