Received: from mx1.redhat.com ([209.132.183.28]:58930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdGNTLE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 14 Jul 2017 15:11:04 -0400
Date: Fri, 14 Jul 2017 14:11:01 -0500
From: "Bill O'Donnell" <billodo@redhat.com>
Subject: Re: [PATCH] xfs/424: test xfs_db to ensure type size taken into
 account with new type
Message-ID: <20170714191101.GA28897@redhat.com>
References: <20170712183112.5255-1-billodo@redhat.com>
 <20170714142733.7386-1-billodo@redhat.com>
 <75d5ddb1-dca8-c96c-f395-e4c213cd5cf0@sandeen.net>
 <20170714164723.GA8033@redhat.com>
 <3de7ad6b-6756-4555-e1ac-142926016524@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de7ad6b-6756-4555-e1ac-142926016524@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jul 14, 2017 at 02:01:31PM -0500, Eric Sandeen wrote:
> 
> 
> On 07/14/2017 11:47 AM, Bill O'Donnell wrote:
> > On Fri, Jul 14, 2017 at 10:42:57AM -0500, Eric Sandeen wrote:
> 
> 
> >>> +# for different sector sizes, ensure no CRC errors are falsely reported
> >>> +
> >>> +# Supported types include: agf, agfl, agi, attr3, bmapbta,
> >>> +# bmapbtd, bnobt, cntbt, data, dir3, dqblk, inobt, inodata,
> >>> +# inode, log, rtbitmap, rtsummary, sb, symlink, text, finobt.
> >>
> >> This leaves me wondering why we don't test most of the above ;)
> >>
> >>> +# For various sector sizes, test some types that involve type size.
> >>> +for SECTOR_SIZE in 512 1024 2048 4096; do
> >>> +    $MKFS_XFS_PROG -f -s size=$SECTOR_SIZE $SCRATCH_DEV > /dev/null
> >>> +    for TYPE in agf agi agfl sb; do
> >>> +	DADDR=`$XFS_DB_PROG -c "$TYPE" -c "daddr" $SCRATCH_DEV | _filter_dbval`
> >>> +	$XFS_DB_PROG -c "$TYPE" -c "daddr 42" -c "daddr $DADDR" -c "type $TYPE" $SCRATCH_DEV
> >>
> >> Hm is there a reason for the first "-c $TYPE" or even the "daddr 42" in the line just above?
> > It's drawn from the reproducer test case.
> > The first "-c $TYPE" sets the object, "daddr 42" is an arbitrary address set. Without
> > the daddr change and change-back, the test will pass even without the recent xfs_db
> > xfsprogs change.
> 
> Really?  Not here, xfsprogs-4.5.0 :
> 
> # xfs_db -c "daddr 2" -c "type agi" fsfile
> Metadata CRC error detected at xfs_agi block 0x2/0x200

Ahh, ok, you're correct - I'll modify the test accordingly.
Thanks-
Bill


> 
> 
> -Eric
