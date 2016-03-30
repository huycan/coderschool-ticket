require 'rails_helper'

RSpec.describe TicketType, type: :model do
  before do
    @user1 = User.new(email: "a@b.c", password: "1", password_confirmation: "1")
    @user1.save(validate: false)
  
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
    @e1 = Event.create({
      name: 'Việt Nam Thử Thách Chiến Thắng', 
      published: true,
      starts_at: 1.days.from_now.utc,
      ends_at: 12.days.from_now.utc,
      venue: dalat,
      category: Category.find_by(name: 'Everything Else'),
      hero_image_url: 'https://az810747.vo.msecnd.net/eventcover/2015/10/25/C6A1A5.jpg?w=1040&maxheight=400&mode=crop&anchor=topcenter',
      user_id: @user1.id,
      extended_html_description: <<-DESC
        <p style="text-align:center"><span style="font-size:20px">VIỆT NAM THỬ THÁCH CHIẾN THẮNG 2016</span></p>
        <p style="text-align:center"><span style="font-size:20px">Giải đua xe đạp địa hình 11-13/03/2016</span></p>
        <p style="text-align:center"><span style="font-size:16px"><span style="font-family:arial,helvetica,sans-serif">Việt Nam Th</span>ử Thách Chiến Thắng là giải đua xe đạp địa hình được tổ chức như một sự tri ân, và cũng nhằm thỏa mãn lòng đam mẹ của những người yêu xe đạp địa hình nói chung, cũng như cho những ai đóng góp vào môn thể thao đua xe đạp tại thành phố Hồ Chí Minh. Cuộc đua diễn ra ở thành phố cao nguyên hùng vĩ Đà Lạt, với độ cao 1,500m (4,900ft) so với mặt nước biển. Đến với đường đua này ngoài việc tận hưởng cảnh quan nơi đây, bạn còn có cơ hội biết thêm về nền văn hóa của thành phố này. </span></p>
        <p style="text-align:center"><span style="font-size:16px">Hãy cùng với hơn 350 tay đua trải nghiệm 04 lộ trình đua tuyệt vời diễn ra trong 03 ngày tại Đà Lạt và bạn sẽ có những kỉ niệm không bao giờ quên!</span></p>
        <p style="text-align:center"><span style="font-size:16px">Để biết thêm thông tin chi tiết và tạo thêm hứng khởi cho cuộc đua 2016, vui lòng ghé thăm trang web</span></p>
        <p style="text-align:center"><span style="font-size:16px"><strong><span style="background-color:transparent; color:rgb(0, 0, 0)">www.vietnamvictorychallenge.com. </span></strong></span></p>
      DESC
    })

    @t1 = TicketType.new(name: '2016 Việt Nam Thử Thách Chiến Thắng dành cho những tay đua đăng kí sớm.', price: 500000, max_quantity: 95)
    @t2 = TicketType.new(name: 'Việt Nam Thử Thách Chiến Thắng ( Giá chính thức)', price: 2000000, max_quantity: 5)
    @e1.ticket_types << @t1
    @e1.ticket_types << @t2
  end

  describe "#remaining?" do
    it "should calculate correct remaining tickets" do
      @ticket = Ticket.create! ticket_type_id: @t1.id, quantity: 5
      expect(TicketType.find(@t1.id).remaining?).to eq 90
    end
  end

  describe "#buyable?" do
    it "let the ticket be buyable if there are remaining stock" do
      @ticket = Ticket.new quantity: 5
      expect(TicketType.find(@t1.id).buyable? 1).to be true
    end

    it "let the ticket be buyable if there are no remaining stock" do
      @ticket = Ticket.new quantity: 95
      expect(TicketType.find(@t1.id).buyable? 1).to be true
    end
  end
end
