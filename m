Received: from mail-pl1-f193.google.com ([209.85.214.193]:33608 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeKLA0v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Nov 2018 19:26:51 -0500
Date: Sun, 11 Nov 2018 22:37:59 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 0/7] fstests: test Btrfs swapfile support
Message-ID: <20181111143759.GA3889@desktop>
References: <cover.1541193856.git.osandov@fb.com>
 <20181104160931.GE12788@desktop>
 <20181106130630.GA24115@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106130630.GA24115@twin.jikos.cz>
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org, kernel-team@fb.com, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 06, 2018 at 02:06:30PM +0100, David Sterba wrote:
> On Mon, Nov 05, 2018 at 12:09:31AM +0800, Eryu Guan wrote:
> > On Fri, Nov 02, 2018 at 02:29:35PM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > This series fixes a couple of generic swapfile tests and adds some
> > > Btrfs-specific swapfile tests. Btrfs swapfile support is scheduled for
> > > 4.21 [1].
> > > 
> > > 1: https://www.spinics.net/lists/linux-btrfs/msg83454.html
> > > 
> > > Thanks!
> > 
> > Thanks for the fixes and new tests!
> > 
> > > 
> > > Omar Sandoval (7):
> > >   generic/{472,496,497}: fix $seeqres typo
> > >   generic/{472,496}: fix swap file creation on Btrfs
> > 
> > I've merged above two patches, they're two obvious bug fixes.
> > 
> > >   btrfs: test swap file activation restrictions
> > >   btrfs: test invalid operations on a swap file
> > >   btrfs: test swap files on multiple devices
> > >   btrfs: test device add/remove/replace with an active swap file
> > >   btrfs: test balance and resize with an active swap file
> > 
> > These tests look fine to me, but it'd be really great if btrfs folks
> > could help review above tests and provide Reviewed-by tags.
> 
> All look good to me,
> 
> Reviewed-by: David Sterba <dsterba@suse.com>

Thanks a lot for the review!

> 
> A few nits I saw:
> 
> - the command names should not be shortened, ie. 'btrfs subvolume
>   snapshot' instead of 'btrfs subvol snap'
> - the test description (eg. 3/7 and 4/7) could mention which case is
>   tested, eg. swapfile with compression or COW or snapshot
> - 4/7 has typo 'nowcow' in a comment

I've addressed these nits on commit.

Thanks,
Eryu
