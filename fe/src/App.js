import './App.css';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { Layout, Menu } from 'antd';
import HomeScreen from './screen/HomeScreen';
import SigninScreen from './screen/SigninScreen';


function App() {
  const { Header, Content, Footer } = Layout;

  return (
    <BrowserRouter>
      <div className="App">
        <Layout className="layout">
          <Header className=''>
            <img
              className="logo"
              src="../xendit.png"
              alt="logo"
              height="50px"
            />
          </Header>
          <Content style={{ padding: '0 50px' }}>
            <div style={{ margin: '24px 0' }}>
            </div>
            <main>
              <Routes>
                <Route path="/" element={<HomeScreen/>} exact />
                <Route path="/signin" element={<SigninScreen/>} exact />
              </Routes>
            </main>
          </Content>
          <Footer style={{ textAlign: 'center' }}>Ant Design ©2022 Created by Ant UED</Footer>
        </Layout>
      </div>
    </BrowserRouter>
  );
}

export default App;
