Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964811AbbC0JTZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 Mar 2015 05:19:25 -0400
Date: Fri, 27 Mar 2015 17:19:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v6] fstests: Tests can use any name now, not 3 digits
 only.
Message-ID: <20150327091921.GF4810@dhcp-13-216.nay.redhat.com>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427383991-14789-1-git-send-email-jtulak@redhat.com>
 <20150327072539.GB4810@dhcp-13-216.nay.redhat.com>
 <1261993987.3620806.1427447733123.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1261993987.3620806.1427447733123.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 27, 2015 at 05:15:33AM -0400, Jan Tulak wrote:
> 
> 
> ----- Original Message -----
> > From: "Eryu Guan" <eguan@redhat.com>
> > To: "Jan Ťulák" <jtulak@redhat.com>
> > Cc: fstests@vger.kernel.org, lczerner@redhat.com, dsterba@suse.cz
> > Sent: Friday, 27 March, 2015 8:25:39 AM
> > Subject: Re: [PATCH v6] fstests: Tests can use any name now, not 3 digits only.
> > 
> > [...]
> > 
> > (( 10#$foundId > 10#$id )) part is tricky, I have to lookup the bash
> > manpage to understand it :)
> > 
> > 10 is the default base, the "10#" part can be omitted.
> > 
> > But I think simple [ $foundId -gt $id ] is better, and David Sterba is
> > OK with it too now (in another reply) :-)
> > 
> > 
> > Thank you so much for continuous improvements!
> > 
> > Eryu
> 
> The 10 base was necessary here, because as I found, (( )) takes numbers beginning with zeroes as octal. So it complained about tests like 008, 009, 019, 029... The [ ] does not complain, so I will put it back here. :-)

Ah, I missed that, lesson learned.

Thanks,
Eryu
> 
> And thanks for patience. :-)
> Jan
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
