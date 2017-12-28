Received: from imap.thunk.org ([74.207.234.97]:59196 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752873AbdL1Dly (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Dec 2017 22:41:54 -0500
Date: Wed, 27 Dec 2017 22:41:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: xfstests: generic/342 run failed in f2fs
Message-ID: <20171228034143.GA30269@thunk.org>
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
 <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
 <ee17d403-6ede-e7a0-da54-baf276e1fc97@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee17d403-6ede-e7a0-da54-baf276e1fc97@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Sandeen <sandeen@sandeen.net>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 28, 2017 at 11:17:09AM +0800, Chao Yu wrote:
> > Indeed. Actually, since one of our goals was to reduce fsync latencies for
> > Android, we decided to support posix in a minimum way. In order to avoid
> 
> Agreed, in order to maximize performance of fsync regular file, we'd better
> not change current sematic of f2fs' fsync so far, moreover, there is no
> such requirement from upper layer application.

The cost of forcing an fsync on the parent directory only if the
regular file was just created should really be minimal.  Most of the
performance critical use cases for fsync() is after writing data on an
already-existing file.

Even in the case where a package manager is writing, say, lots of
newly created files followed by an fsync (such as a 21 megabyte docker
binary) the overhead of including a handful of 4k metadata blocks for
the containing directory to make sure /usr/bin/docker exists as part
of the fsync() is in the noise compared to all of the other data
blocks being written by the package manager.

So I suspect the concerns of "oh, we can't provide the same guarantees
as ext4 and f2fs" are a bit overblown here.  But ultimately, that's up
to the f2fs developers...

> > IMHO, as a quick fix, it seems we need to handle MS_DIRSYNC likewse xfs.
> > #define MS_DIRSYNC      128     /* Directory modifications are synchronous */
> 
> We have supported that yet in commit b7e1d800031c ("f2fs: implement -o
> dirsync"). ;)

To be clear, we're not talking about dirsync mode where *all*
directory modifications are synchronous.  What we're talking about
here is the case where if you fsync() a regular file, and the regular
file is newly created --- AND ONLY THAT CASE --- to make sure the
parent directory is included in the set of metadata blocks updated by
the fsync() against the regular file.

Best regards,

						- Ted
