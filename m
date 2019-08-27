Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:33678 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfH0CMV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Aug 2019 22:12:21 -0400
Date: Tue, 27 Aug 2019 10:12:05 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [PATCH] common/casefold: only check for the Casefold flag
Message-ID: <20190827021205.GV52397@e18g06458.et15sqa>
References: <20190826175020.28959-1-tytso@mit.edu>
 <20190826211301.GB28066@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826211301.GB28066@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 26, 2019 at 05:13:01PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Aug 26, 2019 at 01:50:20PM -0400, Theodore Ts'o wrote:
> > The _casefold_lsattr_dir function lists all of the file attributes.
> > As result, tests/generic/556.out has an ext4-specific assumption that
> > files will have the Extents attribute.  That won't be true for all
> 
> "files" above should probably be changed "the test directories".
> 
> Eryu, can you make that change before you apply the patch, or do you

Sure, I can fix it on commit.

> want me to resend?
> 
> > file systems, and it won't even be true for ext4 file systems that do
> > not have the extents feature enabled.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> 					- Ted

Thanks!

Eryu
