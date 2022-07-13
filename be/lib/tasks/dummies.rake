# frozen_string_literal: true

namespace :dummies do
  desc 'user, categories, products'
  task user: :environment do
    new_user = User.find_or_initialize_by(email: 'test@gmail.com')
    new_user.password = 'password'
    new_user.save!
  end
  
  task categories: :environment do
    categories = ['home_audio', 'kitchen_appliances', 'smartphone', 'computer', 'camera']
    image_url = [
      'https://images.tokopedia.net/img/cache/500-square/product-1/2018/8/30/25596510/25596510_b0fbac63-3ec1-4545-8dac-235df0f778f3_700_442.jpg',
      'https://www.lux-review.com/wp-content/uploads/2022/01/Kitchen-Appliances.jpg',
      'https://asset.kompas.com/crops/dgtxSSEPl9_0q8aMRY0G1F70U9E=/141x0:1221x720/750x500/data/photo/2021/07/07/60e55baa134ab.jpeg',
      'https://blog.atome.id/wp-content/uploads/2021/07/Yuk-Simak-Kisaran-Harga-Personal-Computer.jpg',
      'https://i1.adis.ws/i/canon/eos-r7-lifestyle_c604337a3b374a94a080d40b43f3a920?$70-30-header-4by3-dt-jpg$'
    ]

    categories.each_with_index do |category, index|
      new_category = Category.find_or_initialize_by(name: category)
      new_category.image_url = image_url[index]
      new_category.save!
    end
  end

  task products: :environment do
    audio_product = ['xen-audio', 'xen-audio-2']
    kitchen_appliances = ['xen-kitchen-appliances', 'xen-kitchen-appliances-2']
    smartphone = ['xen-smartphone', 'xen-smartphone-2']
    computer = ['xen-computer', 'xen-computer-2']
    camera = ['xen-camera', 'xen-camera-2']
    categories = ['home_audio', 'kitchen_appliances', 'smartphone', 'computer', 'camera']
    category_product = [audio_product, kitchen_appliances, smartphone, computer, camera]
    image_url = [
      'https://images.tokopedia.net/img/cache/500-square/product-1/2018/8/30/25596510/25596510_b0fbac63-3ec1-4545-8dac-235df0f778f3_700_442.jpg',
      'https://www.lux-review.com/wp-content/uploads/2022/01/Kitchen-Appliances.jpg',
      'https://asset.kompas.com/crops/dgtxSSEPl9_0q8aMRY0G1F70U9E=/141x0:1221x720/750x500/data/photo/2021/07/07/60e55baa134ab.jpeg',
      'https://blog.atome.id/wp-content/uploads/2021/07/Yuk-Simak-Kisaran-Harga-Personal-Computer.jpg',
      'https://i1.adis.ws/i/canon/eos-r7-lifestyle_c604337a3b374a94a080d40b43f3a920?$70-30-header-4by3-dt-jpg$'
    ]

    category_product.each_with_index do |category, i|
      category.each_with_index do |product, j|
        new_product = Product.find_or_initialize_by(name: product)
        attributes = {
          description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          stock: rand(10..40),
          category_id: Category.find_by(name: categories[i]).id,
          image_url: image_url[i],
          price: rand(500000..1000000)
        }
        new_product.assign_attributes attributes
        new_product.save!
      end
    end
  end
end
