Received: from mail-108-mta48.mxroute.com (mail-108-mta48.mxroute.com [136.175.108.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF91F188
	for <fstests@vger.kernel.org>; Sun, 21 Jan 2024 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705810336; cv=none; b=I8883RcZPNUBNuRerQRMKc2KXhoKaLvdLYj95z3kii8tf7AMXA/SmGtZVpbz0md9TeaYQjcb+38BpQO6qCzFCehgIgyxLH166artmnTiFkyTpwgMd30hSHu9kQdhMuVtgImzXNV6HfWzn/burTX9LK5XEacqbQP3vJ6GKis0XuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705810336; c=relaxed/simple;
	bh=USoWfbrLCHP08/BiLgcVJYCsYQRrhGsSlxACS4R1t/Y=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=be1vwh2yXDyH3QBcRQQrCFw4UD6Ma6ZMI63BUAbR3eADBhLN+G3hjQ/aKjT+Mlf9aLPt5BtiAWr8BdGt8UztAUqmIRWxwV8iQbCknI1YhTvYaFILR5GKcP1G3EPSwUzf9hjbTfJRFGG1tged2i84sJG+Qc313vW9yA3fBv4ZfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=uKA6TG9r; arc=none smtp.client-ip=136.175.108.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="uKA6TG9r"
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta48.mxroute.com (ZoneMTA) with ESMTPSA id 18d2a3352570003727.003
 for <fstests@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 21 Jan 2024 04:07:03 +0000
X-Zone-Loop: 95b3718b6d8646df19549b30e3e893f2fbd9606d8cc3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+u9G9L+4HwumXflYhe2+AtfZUA0wkw5t5/J+RW/Wooc=; b=uKA6TG9r4HapP0vJr4uNM0M4wK
	57PHBH0WB/O14KqYfJhdZOOQEYyeCVwNCHBgsLmBOLcuieP0Wp5P2nVAPf+2+MsIlYD1EEjphVyoJ
	7f7VXiEOfs/0OYy911MWcRyuhjOib4h8UkHcM+dA+ke5FfO5xuwf3gfNJNLpYp45Sz10muXW9Je0c
	15RQBr5g2/yNGwGxGVg9zXH5JQKXx9N9ZnsghgE6ttD1Yg53i+6wBMeG7WdAQVcZCzmvba1jo1kx6
	BCNaBzpuBjyNUhPTiAe7UAmeT1zzIevgzNPRc/krHt1u4g7qoD88W/aIy/1HvQeEaqAbbCtuBXEU1
	3ZfBz5VQ==;
References: <20240117092309.1134595-1-glass.su@suse.com>
 <20240117092309.1134595-2-glass.su@suse.com> <ZagUdl+DlxIw+siv@bfoster>
 <h6jb49cm.fsf@damenly.org> <ZaqepfRjb1vU+nDw@bfoster>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Su Yue <l@damenly.org>, Su Yue <glass.su@suse.com>,
 fstests@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] common/rc: improve block size support for bcachefs
Date: Sun, 21 Jan 2024 12:00:47 +0800
In-reply-to: <ZaqepfRjb1vU+nDw@bfoster>
Message-ID: <cytv49hm.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Fri 19 Jan 2024 at 11:09, Brian Foster <bfoster@redhat.com> 
wrote:

> On Thu, Jan 18, 2024 at 10:59:14AM +0800, Su Yue wrote:
>>
>> On Wed 17 Jan 2024 at 12:55, Brian Foster <bfoster@redhat.com> 
>> wrote:
>>
>> > On Wed, Jan 17, 2024 at 05:23:09PM +0800, Su Yue wrote:
>> > > For bcachefs, def_blksz is never assigned even MKFS_OPTIONS 
>> > > contains
>> > > option
>> > > '--block_size'. So block size of bcachefs on scratch dev is 
>> > > always
>> > > 4096
>> > > if _scratch_mkfs_sized is called without second parameter.
>> > >
>> > > Add the pattern to set def_blksz if '--block_size' is given 
>> > > in
>> > > MKFS_OPTIONS.
>> > >
>> > > Signed-off-by: Su Yue <glass.su@suse.com>
>> > > ---
>> > > changelog:
>> > > v2:
>> > >     Born.
>> > > ---
>> > >  common/rc | 3 +++
>> > >  1 file changed, 3 insertions(+)
>> > >
>> > > diff --git a/common/rc b/common/rc
>> > > index 31c21d2a8360..6a01de69cf05 100644
>> > > --- a/common/rc
>> > > +++ b/common/rc
>> > > @@ -950,6 +950,9 @@ _scratch_mkfs_sized()
>> > >  	jfs)
>> > >  		def_blksz=4096
>> > >  		;;
>> > > +	bcachefs)
>> > > +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 
>> > > 's/.*(--block_size)[
>> > > =]?+([0-9]+).*/\2/p'`
>> > > +		;;
>> >
>> > So if the default bcachefs block size is 512b, I wonder if 
>> > this should
>> > do something like what the udf branch does a few lines above 
>> > and
>> >
>> mkfs.bcachefs decides block size by querying statbuf.st_blksize 
>> or
>> BLKPBSZGET from the device if the option is not given.
>>
>> > override the hardcoded default of 4k. ISTM this whole thing 
>> > would be
>> > more robust if it just elided the param in the default cases 
>> > and let the
>> > associated mkfs tool use its own default, but that's probably 
>> > a separate
>> > issue. Hm?
>> >
>> Since there is no default block size of bcachefs, maybe we can 
>> let
>> mkfs.bcachefs decide on its own but it will make chaos when 
>> somebody
>> reports an unreproducible BUG due to the different block_size 
>> even
>> we have same local.config. It just happened...
>> So for now, I think 4096 is a resonable value of bcachefs block 
>> size.
>>
>
> I think we run into this no matter what if we pick a size out of 
> a hat,
> regardless of what the value is. If somebody is testing with 
> default
> blocksize (i.e. based on mkfs) on a filesystem where the default 
> isn't
> actually 4k, then it seems quite unexpected that 
> _scratch_mkfs_sized
> would use something different from _scratch_mkfs when a block 
> size isn't
> explicitly specified. That's exactly the situation we ran into 
> with the
> generic/361 thing where I would have expected this test to use 
> 512b
> blocks.
>
> ISTM that the 4k value in _scratch_mkfs_sized() is mainly a last 
> resort
> default value so the $blocks calculation can work for any 
> filesystem
> that might not be properly supported by the function. The 
> function looks
> a little wonky overall, but I think there are at least a couple 
> options
> to improve things for bcachefs. FWIW, it also looks to me that 
> nothing
> actually passes a blocksize param to _scratch_mkfs_sized, so 
> perhaps we
> could just drop that blocksize=$2 parameter across the board as 
> a
> simplification?
>
Maybe it can be dropped. The only user is generic/466

> With that, I think bcache could either:
>
> 1. Do something like def_blksize=`blockdev --getpbsz 
> $SCRATCH_DEV` in
> the first switch if no block size is specified in MKFS_OPTIONS 
> (or
> whatever best mimics mkfs logic).
>
> OR
>
> 2. Do something like the following in the last switch:
>
> 	[ -n $def_blksize ] && def_blksize="--block_size=$def_blksize"
> 	$MKFS_BCACHEFS_PROG ... $def_blksize $SCRATCH_DEV
>
> ... to allow mkfs to determine the block size. I _think_ that 
> works
> because the bcachefs format doesn't depend on $blocks at all, so
> whatever $blocksize was set to is irrelevent unless $def_blksize 
> was set
> above, but I could be missing something. That also assumes 
> blocksize
> wasn't set to something by the caller.
>
> If correct, option #2 seems a little cleaner to me, but other
> thoughts/ideas?
>
Option 2 is preferable. I would code it as(on more varaiable for 
readability):

local blocksize_opt

[ -n $def_blksize ] && blockzie_opt="--block_size=$def_blksize"
$MKFS_BCACHEFS_PROG ... $blocksize_opt $SCRATCH_DEV

--
Su
>
> Brian
>
>> --
>> Su
>> >
>> > Brian
>> >
>> > >  	esac
>> > >
>> > >  	[ -n "$def_blksz" ] && blocksize=$def_blksz
>> > > --
>> > > 2.43.0
>> > >
>>
