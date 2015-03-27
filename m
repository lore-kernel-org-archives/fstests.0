Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:55180 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbbC0JPg convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 Mar 2015 05:15:36 -0400
Date: Fri, 27 Mar 2015 05:15:33 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <1261993987.3620806.1427447733123.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427383991-14789-1-git-send-email-jtulak@redhat.com> <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
Subject: Re: [PATCH v6] fstests: Tests can use any name now, not 3 digits
 only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "Eryu Guan" <eguan@redhat.com>
> To: "Jan Ťulák" <jtulak@redhat.com>
> Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
> Sent: Friday, 27 March, 2015 8:25:39 AM
> Subject: Re: [PATCH v6] fstests: Tests can use any name now, not 3 digits only.
> 
> [...]
> 
> (( 10#$foundId > 10#$id )) part is tricky, I have to lookup the bash
> manpage to understand it :)
> 
> 10 is the default base, the "10#" part can be omitted.
> 
> But I think simple [ $foundId -gt $id ] is better, and David Sterba is
> OK with it too now (in another reply) :-)
> 
> 
> Thank you so much for continuous improvements!
> 
> Eryu

The 10 base was necessary here, because as I found, (( )) takes numbers beginning with zeroes as octal. So it complained about tests like 008, 009, 019, 029... The [ ] does not complain, so I will put it back here. :-)

And thanks for patience. :-)
Jan
