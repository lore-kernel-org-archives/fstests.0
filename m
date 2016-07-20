Received: from mx1.redhat.com ([209.132.183.28]:43957 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcGTEwU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jul 2016 00:52:20 -0400
Date: Wed, 20 Jul 2016 12:52:17 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/071: require falloc -k
Message-ID: <20160720045217.GT27776@eguan.usersys.redhat.com>
References: <1468829204-24593-1-git-send-email-hch@lst.de>
 <20160718084714.GD27776@eguan.usersys.redhat.com>
 <20160719041718.GA17223@lst.de>
 <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
 <20160719083047.GA21083@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160719083047.GA21083@lst.de>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 19, 2016 at 10:30:47AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 18, 2016 at 11:49:57PM -0700, Eric Sandeen wrote:
> > Some tests actually do run xfs_io on a real file, but we probably
> > don't want to go that way.
> > 
> > The test for finding it in help output seems way too specific,
> > 
> > _require_xfs_io_command "pwrite" "-Z"
> > 
> > fails as well because it doesn't hit the specific format in
> > the grep.
> > 
> > What if we loosen up the test; is this too loose? (look for param
> > preceded by whitespace or square bracket)
> 
> Seems like it's not loose enough as it still tries to run the test
> on NFS.

For this NFSv4.2 case, I think we have to actually run "falloc -k" to
check whether the underlying fs supports (FALLOC_FL_KEEP_SIZE) or not.

Current check in _require_xfs_io_command only checks whether xfs_io
knows the given option, not the underlying fs. And in this NFSv4.2 case,
NFSv4.2 supports fallocate(2), and xfs_io falloc command knows "-k"
option, so test runs on NFS.

Thanks,
Eryu
