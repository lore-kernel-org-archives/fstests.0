Received: from mail-yb1-f194.google.com ([209.85.219.194]:36839 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbeKABDr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 Oct 2018 21:03:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id w16-v6so6844164ybp.3
        for <fstests@vger.kernel.org>; Wed, 31 Oct 2018 09:05:09 -0700 (PDT)
Date: Wed, 31 Oct 2018 12:05:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fstests: fix fssum to actually ignore file holes when
 supposed to
Message-ID: <20181031160504.hldii2zywr2n7sp6@macbook-pro-91.dhcp.thefacebook.com>
References: <20181029094340.18154-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029094340.18154-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Oct 29, 2018 at 09:43:40AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Unless the '-s' option is passed to fssum, it should not detect file holes
> and have their existence influence the computed checksum for a file. This
> tool was added to test btrfs' send/receive feature, so that it checks for
> any metadata and data differences between the original filesystem and the
> filesystem that receives send streams.
> 
> For a long time the test btrfs/007, which tests btrfs' send/receive with
> fsstress, fails sporadically reporting data differences between files.
> However the md5sum/sha1sum from the reported files in the original and
> new filesystems are the same. The reason why fssum fails is because even
> in normal mode it still accounts for number of holes that exist in the
> file and their respective lengths. This is done using the SEEK_DATA mode
> of lseek. The btrfs send feature does not preserve holes nor prealloc
> extents (not supported by the current protocol), so whenever a hole or
> prealloc (unwritten) extent is detected in the source filesystem, it
> issues a write command full of zeroes, which will translate to a regular
> (written) extent in the destination filesystem. This is why fssum reports
> a different checksum. A prealloc extent also counts as hole when using
> lseek.
> 
> For example when passing a seed of 1540592967 to fsstress in btrfs/007,
> the test fails, as file p0/d0/f7 has a prealloc extent in the original
> filesystem (in the incr snapshot).
> 
> Fix this by making fssum just read the hole file and feed its data to the
> digest calculation function when option '-s' is not given. If we ever get
> btrfs' send/receive to support holes and fallocate, we can just change
> the test and pass the '-s' option to all fssum calls.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
