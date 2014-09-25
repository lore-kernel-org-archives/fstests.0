Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25528 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbaIYPIe (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 25 Sep 2014 11:08:34 -0400
Message-ID: <1411657705.26791.51.camel@jtulak>
Subject: Re: Performance testing
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 25 Sep 2014 17:08:25 +0200
In-Reply-To: <87iokmtwp5.fsf@openvz.org>
References: <1410943724.31777.31.camel@jtulak> <87iokmtwp5.fsf@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, 2014-09-17 at 13:36 +0400, Dmitry Monakhov wrote:
> On Wed, 17 Sep 2014 10:48:44 +0200, Jan Tulak <jtulak@redhat.com> wrote:
> > 
> > Comments and questions? :-)
> This kind of functionality already implemented in autotest via perf keyval
> http://autotest.readthedocs.org/en/latest/main/local/Keyval.html
> test case may produce any numbers of keyvalues which will be
> automatically stored to standard database for later comparison.

Thanks for the info. I think Autotest could be used as the upper layer,
for saving and comparing the results. But I will need to look more on
how it would works.

Cheers,
Jan Tulak

> > 
> > Jan Tulak
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


