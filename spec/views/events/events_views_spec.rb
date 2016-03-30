require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  login_user
  before do
      @user = User.find_by email: "a@b.c"
      User.new(email: "x@y.z", password: "2", password_confirmation: "2").save(validate: false)

      # Create Regions
      ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong'].each do |r|
        Region.create(name: r)
      end
      # Create Categories
      ['Entertainment', 'Learning', 'Everything Else'].each do |c|
        Category.create(name: c)
      end

      # First event:
      # Việt Nam Thử Thách Chiến Thắng

      dalat = Venue.create({
        name: 'Da Lat City',
        full_address: 'Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng',
        region: Region.find_by(name: 'Lam Dong')
      })

      @e = Event.create({
        name: 'Việt Nam Thử Thách Chiến Thắng', 
        published: true,
        starts_at: Faker::Time.between(1.days.from_now.utc, 5.days.from_now.utc, :all),
        ends_at: Faker::Time.between(7.days.from_now.utc, 12.days.from_now.utc, :all),
        venue: dalat,
        category: Category.find_by(name: 'Everything Else'),
        hero_image_url: 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter',
        user_id: @user.id,
        extended_html_description: <<-DESC
          <p style="text-align:center"><span style="font-size:20px">VIỆT NAM THỬ THÁCH CHIẾN THẮNG 2016</span></p>
          <p style="text-align:center"><span style="font-size:20px">Giải đua xe đạp địa hình 11-13/03/2016</span></p>
          <p style="text-align:center"><span style="font-size:16px"><span style="font-family:arial,helvetica,sans-serif">Việt Nam Th</span>ử Thách Chiến Thắng là giải đua xe đạp địa hình được tổ chức như một sự tri ân, và cũng nhằm thỏa mãn lòng đam mẹ của những người yêu xe đạp địa hình nói chung, cũng như cho những ai đóng góp vào môn thể thao đua xe đạp tại thành phố Hồ Chí Minh. Cuộc đua diễn ra ở thành phố cao nguyên hùng vĩ Đà Lạt, với độ cao 1,500m (4,900ft) so với mặt nước biển. Đến với đường đua này ngoài việc tận hưởng cảnh quan nơi đây, bạn còn có cơ hội biết thêm về nền văn hóa của thành phố này. </span></p>
          <p style="text-align:center"><span style="font-size:16px">Hãy cùng với hơn 350 tay đua trải nghiệm 04 lộ trình đua tuyệt vời diễn ra trong 03 ngày tại Đà Lạt và bạn sẽ có những kỉ niệm không bao giờ quên!</span></p>
          <p style="text-align:center"><span style="font-size:16px">Để biết thêm thông tin chi tiết và tạo thêm hứng khởi cho cuộc đua 2016, vui lòng ghé thăm trang web</span></p>
          <p style="text-align:center"><span style="font-size:16px"><strong><span style="background-color:transparent; color:rgb(0, 0, 0)">www.vietnamvictorychallenge.com. </span></strong></span></p>
        DESC
      })
  end

  it "renders _event partial for each event" do
    assign(:events, [@e])
    render
    expect(view).to render_template(:partial => "_event", :count => 1)
  end
end

RSpec.describe "events/show", :type => :view do
  before do
      @user = User.new(email: "a@b.c", password: "1", password_confirmation: "1")
      @user.save(validate: false)
      User.new(email: "x@y.z", password: "2", password_confirmation: "2").save(validate: false)

      # Create Regions
      ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong'].each do |r|
        Region.create(name: r)
      end
      # Create Categories
      ['Entertainment', 'Learning', 'Everything Else'].each do |c|
        Category.create(name: c)
      end

      # First event:
      # Việt Nam Thử Thách Chiến Thắng

      dalat = Venue.create({
        name: 'Da Lat City',
        full_address: 'Ngoc Phat Hotel 10 Hồ Tùng Mậu Phường 3, Thành phố Đà Lạt, Lâm Đồng, Thành Phố Đà Lạt, Lâm Đồng',
        region: Region.find_by(name: 'Lam Dong')
      })

      @e = Event.create({
        name: 'Việt Nam Thử Thách Chiến Thắng', 
        published: true,
        starts_at: Faker::Time.between(1.days.from_now.utc, 5.days.from_now.utc, :all),
        ends_at: Faker::Time.between(7.days.from_now.utc, 12.days.from_now.utc, :all),
        venue: dalat,
        category: Category.find_by(name: 'Everything Else'),
        hero_image_url: 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter',
        user_id: @user.id,
        extended_html_description: <<-DESC
          <p style="text-align:center"><span style="font-size:20px">VIỆT NAM THỬ THÁCH CHIẾN THẮNG 2016</span></p>
          <p style="text-align:center"><span style="font-size:20px">Giải đua xe đạp địa hình 11-13/03/2016</span></p>
          <p style="text-align:center"><span style="font-size:16px"><span style="font-family:arial,helvetica,sans-serif">Việt Nam Th</span>ử Thách Chiến Thắng là giải đua xe đạp địa hình được tổ chức như một sự tri ân, và cũng nhằm thỏa mãn lòng đam mẹ của những người yêu xe đạp địa hình nói chung, cũng như cho những ai đóng góp vào môn thể thao đua xe đạp tại thành phố Hồ Chí Minh. Cuộc đua diễn ra ở thành phố cao nguyên hùng vĩ Đà Lạt, với độ cao 1,500m (4,900ft) so với mặt nước biển. Đến với đường đua này ngoài việc tận hưởng cảnh quan nơi đây, bạn còn có cơ hội biết thêm về nền văn hóa của thành phố này. </span></p>
          <p style="text-align:center"><span style="font-size:16px">Hãy cùng với hơn 350 tay đua trải nghiệm 04 lộ trình đua tuyệt vời diễn ra trong 03 ngày tại Đà Lạt và bạn sẽ có những kỉ niệm không bao giờ quên!</span></p>
          <p style="text-align:center"><span style="font-size:16px">Để biết thêm thông tin chi tiết và tạo thêm hứng khởi cho cuộc đua 2016, vui lòng ghé thăm trang web</span></p>
          <p style="text-align:center"><span style="font-size:16px"><strong><span style="background-color:transparent; color:rgb(0, 0, 0)">www.vietnamvictorychallenge.com. </span></strong></span></p>
        DESC
      })
  end

  it "displays the event booking page" do
    assign(:event, @e)
    render
    expect(rendered).to include("Việt Nam Thử Thách Chiến Thắng")
  end
end