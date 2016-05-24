Received: from mx1.redhat.com ([209.132.183.28]:36878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbcEXODE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 May 2016 10:03:04 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86B4FA852
	for <fstests@vger.kernel.org>; Tue, 24 May 2016 14:03:03 +0000 (UTC)
Received: from localhost (dhcp-12-144.nay.redhat.com [10.66.12.144])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4OE32Sd003171
	for <fstests@vger.kernel.org>; Tue, 24 May 2016 10:03:03 -0400
Date: Tue, 24 May 2016 22:03:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFD] fstests needs a new maintainer
Message-ID: <20160524140301.GU5140@eguan.usersys.redhat.com>
References: <20160523045350.GF26977@dastard>
 <20160523064138.GA5051@zlang.usersys.redhat.com>
 <20160523145503.GA32314@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160523145503.GA32314@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 23, 2016 at 07:55:03AM -0700, Christoph Hellwig wrote:
> On Mon, May 23, 2016 at 02:41:38PM +0800, Zorro Lang wrote:
> > Thanks for what you did for us. I'm just thinking maybe you can
> > separate fstests maintenance jobs to several different maintainers?
> > Due to fstests project become bigger and bigger, it maybe hard for
> > someone review & merge & verify all kinds of patches.
> > 
> > As I know LTP have "not only one" maintainers. I think we still
> > need someone like you can make important decision for fstests.
> > But for some daily jobs, you can distribute them to others.
> 
> FYI, back when we team-maintained the xfstests-dev repo together with
> all the other xfs -dev repos it worked out fine.  But even with that
> we need someone to volunteer for doing the day to day grunt work.
> 
> While I'd be happy to help out I fear I don't have time to do the
> majority of the work at the moment either.

I'd like to help out to do the day to day dirty work as well, though I
don't have such experience before.

Thanks,
Eryu
