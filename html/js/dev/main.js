'use strict';
(function(){

	var Scripts = (function(){

		function Scripts(){
			this.hoverFriends();
			this.followAllFriends();
			this.followOneFriend();
			$('#friends').find('a').tooltip({'placement': 'bottom'});
		}

		Scripts.prototype.hoverFriends = function(){
			$('#friends').find('a').on('mouseenter', function(){
				var span = $(this).find('span');
				if(span.hasClass('follow')){
					span.addClass('no');
				} else {
					span.addClass('yes');
				}
			}).on('mouseleave', function(){
				var span = $(this).find('span');
				if(span.hasClass('follow')){
					span.removeClass('no');
				} else {
					span.removeClass('no').removeClass('yes');
				}
			});
		};

		Scripts.prototype.followOneFriend = function(){
			$('#friends').find('a').on('click', function(e){
				var loading = $('.loading'),
					msg = $('#msg'),
					t = $(this),
					action = 'follow',
					user = t.attr('data-user');

				if(!loading.is(':visible')){
					loading.slideToggle();

					if(t.find('span').hasClass('follow')){
						action = 'unfollow';
					}

					$.ajax({
						url: '',
						type: 'POST',
						data: {},
						success: function(){
							loading.hide();
							msg.addClass('sucess').find('p').text('You now '+action+' @'+user+'!');

							if(action == 'unfollow'){
								t.find('span').removeClass('follow').each(function(){
									var link = $(this).parent();
									link.attr('data-original-title', 'Follow @'+link.attr('data-user'));
								});
							} else {
								t.find('span').addClass('follow').each(function(){
									var link = $(this).parent();
									link.attr('data-original-title', 'Unfollow @'+link.attr('data-user'));
								});
							}


							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 3000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 3000);
						}
					});
				}
				e.preventDefault();
			});
		};

		Scripts.prototype.followAllFriends = function(){
			$('#followAllFriends').on('click', function(e){
				var loading = $('.loading'),
					msg = $('#msg');
				if(!loading.is(':visible')){
					loading.slideToggle();

					$.ajax({
						url: '',
						type: 'POST',
						data: {},
						success: function(){
							loading.hide();
							msg.addClass('sucess').find('p').text('Congratz, you follow everyone now!');
							msg.slideToggle();
							$('#friends').find('span').addClass('yes').each(function(){
								var link = $(this).parent();
								link.attr('data-original-title', 'Unfollow @'+link.attr('data-user'));
							});
							setTimeout(function(){
								msg.slideToggle();
							}, 3000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 3000);
						}
					});
				}
				e.preventDefault();
			});
		};

		return Scripts;

	})();

	$(document).ready(function(){ new Scripts(); });
})();