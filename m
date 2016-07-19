Received: from verein.lst.de ([213.95.11.211]:54104 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbcGSIay (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 04:30:54 -0400
Date: Tue, 19 Jul 2016 10:30:47 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic/071: require falloc -k
Message-ID: <20160719083047.GA21083@lst.de>
References: <1468829204-24593-1-git-send-email-hch@lst.de> <20160718084714.GD27776@eguan.usersys.redhat.com> <20160719041718.GA17223@lst.de> <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd28494-84e9-1458-5e28-893d02dd5c06@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Christoph Hellwig <hch@lst.de>, Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 11:49:57PM -0700, Eric Sandeen wrote:
> Some tests actually do run xfs_io on a real file, but we probably
> don't want to go that way.
> 
> The test for finding it in help output seems way too specific,
> 
> _require_xfs_io_command "pwrite" "-Z"
> 
> fails as well because it doesn't hit the specific format in
> the grep.
> 
> What if we loosen up the test; is this too loose? (look for param
> preceded by whitespace or square bracket)

Seems like it's not loose enough as it still tries to run the test
on NFS.
