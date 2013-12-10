'use strict';
(function(){

	var Scripts = (function(){

		function Scripts(){
			this.hoverFriends();
			this.followAllFriends();
			this.followOneFriend();
			this.hoverOrgs();
			this.followOneInOrg();
			this.followAllInOrgs();
			this.searchOrg();
			$('#friends').find('a').tooltip({'placement': 'bottom'});
			$('.members').find('li a').tooltip({'placement': 'bottom'});
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
									t.attr('data-original-title', 'Follow @'+t.attr('data-user'));
								});
							} else {
								t.find('span').addClass('follow').each(function(){
									t.attr('data-original-title', 'Unfollow @'+t.attr('data-user'));
								});
							}

							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
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
							}, 6000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						}
					});
				}
				e.preventDefault();
			});
		};

		Scripts.prototype.hoverOrgs = function(){
			$('.members').find('li a').on('mouseenter', function(){
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

		Scripts.prototype.followOneInOrg = function(){
			$('.members').find('li a').on('click', function(e){
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
									t.attr('data-original-title', 'Follow @'+t.attr('data-user'));
								});
							} else {
								t.find('span').addClass('follow').each(function(){
									t.attr('data-original-title', 'Unfollow @'+t.attr('data-user'));
								});
							}

							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						}
					});
				}
				e.preventDefault();
			});
		};

		Scripts.prototype.followAllInOrgs = function(){
			$('.followorg').on('click', function(e){
				var t = $(this),
					loading = $('.loading'),
					msg = $('#msg'),
					org = t.attr('data-org');

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
							t.parent().parent().find('.members span').addClass('yes').each(function(){
								var link = $(this).parent();
								link.attr('data-original-title', 'Unfollow @'+link.attr('data-user'));
							});
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
						}
					});
				}
				e.preventDefault();
			});
		};

		Scripts.prototype.searchOrg = function(){
			classe = this;
			$("#orgForm").on('submit', function(e){
				var input = $('#orgSearch'),
					loading = $('.loading'),
					msg = $('#msg');

				if(input.val() !== '' && !loading.is(':visible')){
					loading.slideToggle();
					$.ajax({
						url: '',
						type: 'POST',
						data: {orgName: input.val()},
						success: function(data){
							var org = JSON && JSON.parse(data) || $.parseJSON(data),
								html;
							loading.hide();

							if(org.name == ''){
								msg.addClass('error').find('p').text('Sorry man, this organization doesn\'t exist!');
								msg.slideToggle();
								setTimeout(function(){
									msg.slideToggle();
								}, 6000);
								return false;
							}

							html = '<div class="org-avatar"><img src="'+org.avatar+'" width="240" height="240" alt=""></div>';
							html += '<div class="members">';
							html += '<h3><span>Members of '+org.name+'</span> <a href="http://github.com/'+org.name+'" class="btn followorg" data=org="'+org.name+'">Follow everyone in '+org.name+'</a></h3><ul>';
							$.each(org.members, function(index, value){
								action = '';
								title = 'Follow';
								if(org.members[index].isFollowed){
									action = 'follow';
									title = 'Unfollow';
								}
								html += '<li><a href="http://github.com/'+org.members[index].user+'" data-toggle="tooltip" title="'+title+' @'+org.members[index].user+'" data-user="'+org.members[index].user+'"><img src="'+org.members[index].avatar+'" width="70" height="70" alt=""><span class="'+action+'"></span></a></li>';
							});
							html += '</ul></div>';

							$('#searchOrg').html(html);
							classe.hoverOrgs();
							classe.followOneInOrg();
							classe.followAllInOrgs();

						},
						error: function(){
							loading.hide();
							msg.addClass('error').find('p').text('Error my friend, try again!');
							msg.slideToggle();
							setTimeout(function(){
								msg.slideToggle();
							}, 6000);
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