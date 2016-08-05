Received: from mx2.suse.de ([195.135.220.15]:57274 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859AbcHEHvq (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 5 Aug 2016 03:51:46 -0400
Date: Fri, 5 Aug 2016 09:51:12 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4/022: Test expansion of inode size
Message-ID: <20160805075112.GA15550@quack2.suse.cz>
References: <1470326975-13087-1-git-send-email-jack@suse.cz>
 <20160805055209.GV27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160805055209.GV27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri 05-08-16 13:52:09, Eryu Guan wrote:
> On Thu, Aug 04, 2016 at 06:09:35PM +0200, Jan Kara wrote:
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
> 
> Wrong copyright? I can change it to "SUSE Linux Products GmbH." (grabbed
> from your previous new tests)

Yeah, I copied some other test and forgot to change the copyright. All other
changes you suggest look good as well. Thanks for fixing them up!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
