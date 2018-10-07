Received: from mail-pg1-f193.google.com ([209.85.215.193]:44793 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeJGW0G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Oct 2018 18:26:06 -0400
Date: Sun, 7 Oct 2018 23:18:21 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 5/9] generic/102 open code dev_size
 _scratch_mkfs_sized()
Message-ID: <20181007151821.GP17817@desktop>
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-6-git-send-email-anand.jain@oracle.com>
 <6bdc26df-7beb-53dd-69a2-c3d1789cf3c9@suse.com>
 <d5e4b2ef-6e8b-f760-9e5a-13c93533abb2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e4b2ef-6e8b-f760-9e5a-13c93533abb2@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>
Cc: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 26, 2018 at 12:08:56PM +0800, Anand Jain wrote:
> 
> 
> On 09/25/2018 06:54 PM, Nikolay Borisov wrote:
> > 
> > 
> > On 25.09.2018 07:24, Anand Jain wrote:
> > > Open code helps to grep and find out parameter sent to the
> > > _scratch_mkfs_sized here.
> > > 
> > > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > 
> > IMO this is noise, you can just as simply do
> > "grep _scratch_mkfs_sized" and then open the file to inspect the actual
> > argument. But it's up to the xfstest maintainers
> 
>  I am ok. Its just a nice cleanup.
> 
> Thanks, Anand

I prefer dropping patch 5/6/7, as I don't think they're that necessary.

BTW, other patches from this series but patch 3 ("geneirc/077 fix min
size for btrfs") look fine to me, I'm taking them in this week's update.

Thanks,
Eryu

> 
> > > ---
> > >   tests/generic/102 | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/102 b/tests/generic/102
> > > index faf940ac5070..aad496a5bc69 100755
> > > --- a/tests/generic/102
> > > +++ b/tests/generic/102
> > > @@ -31,8 +31,7 @@ _require_scratch
> > >   rm -f $seqres.full
> > > -dev_size=$((512 * 1024 * 1024))     # 512MB filesystem
> > > -_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
> > > +_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> > >   _scratch_mount
> > >   for ((i = 0; i < 10; i++)); do
> > > 
