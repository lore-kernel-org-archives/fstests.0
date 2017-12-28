Received: from sandeen.net ([63.231.237.45]:43190 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdL1Q7W (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 28 Dec 2017 11:59:22 -0500
Subject: Re: xfstests: generic/342 run failed in f2fs
References: <2d524305-ecb5-8600-a92a-d79b717b8d13@intel.com>
 <e367054d-046d-d6e5-943c-7fbe10493029@sandeen.net>
 <d20cb58e-6646-a7de-bff1-8b7783a30664@intel.com>
 <d5ff659d-c659-ca47-3999-2f4b16629e42@sandeen.net>
 <20171225163102.GB14399@thunk.org>
 <20171227191130.GB13490@jaegeuk-macbookpro.roam.corp.google.com>
 <20171228090903.GQ5858@dastard>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <a4091bfd-a054-b157-00c8-806357da7183@sandeen.net>
Date: Thu, 28 Dec 2017 08:59:18 -0800
MIME-Version: 1.0
In-Reply-To: <20171228090903.GQ5858@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, philip.li@intel.com
List-ID: <fstests@vger.kernel.org>

On 12/28/17 1:09 AM, Dave Chinner wrote:
...

> There's a whole lot more detail in the kernel commit 2be63d5ce929
> ("Btrfs: fix file loss on log replay after renaming a file and
> fsync") but my point is that we considered this a btrfs filesystem
> bug and so changing the test defeats it's purpose as a regression
> test for the btrfs bug.
> 
> So IMO the test should not be changed. And I think we should be
> consistent and consider this f2fs failure as a f2fs bug that needs
> fixing to bring it's behaviour in line with xfs, ext4, and btrfs.
> 
> Remember this when quoting POSIX about fsync behaviour: Posix is a
> terrible standard when it comes to data integrity. We go way, way
> beyond what POSIX specifies as a valid fsync implementation (i.e.
> posix allows "do nothing and return success" as a conformant
> implementation). Ext4, XFS and btrfs all have strictly ordered
> metadata crash recovery semantics and all of the crash recovery
> tests expect this behaviour from the filesytem being tested. The
> underlying intention is that by encoding it into these tests, all
> widely used and future linux filesystems meet or exceed this crash
> integrity requirement.
> 
> IOWs, changing the test is the wrong thing to do on many levels....
> 
> Cheers,
> 
> Dave.
> 

Thanks for digging into the btrfs commit which changed the behavior
tested by this testcase, I had meant to do that. 

Yeah, that's all fair, for sure.  But this shouldn't be implicit in the
testcase; it should explicitly document that it is testing a de-facto
new standard adhered to by several filesystems, what that standard is,
etc, and not leave it to the reader.  ;)  

If a filesystem explicitly chooses not to adhere to that standard they
/could/ opt out of the test.

It's makes a lot of sense for linux filesystems to behave in consistent
ways, but if we're going to start enforcing that through xfstests we
need to be very clear about it, IMHO.


-Eric
