Received: from verein.lst.de ([213.95.11.211]:53157 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbcGSERW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 00:17:22 -0400
Date: Tue, 19 Jul 2016 06:17:18 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic/071: require falloc -k
Message-ID: <20160719041718.GA17223@lst.de>
References: <1468829204-24593-1-git-send-email-hch@lst.de> <20160718084714.GD27776@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160718084714.GD27776@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 18, 2016 at 04:47:14PM +0800, Eryu Guan wrote:
> This stops generic/071 from running no matter what filesystem it's
> testing, this is because _require_xfs_io_command only checks whether
> xfs_io knows the option (-k) by searching it in help message, not really
> running it, i.e.

Well, we can at least add the documentation as that would be useful
on it's own.  I'll look into a patch.

> Perhaps we should update _require_xfs_io_command to actually run the
> command with the provided additional option?

I'll have to look at the archives, but I remember we had a reason for
this way of probing for feature support.
