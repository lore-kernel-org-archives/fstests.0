Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F80BBA21
	for <fstests@vger.kernel.org>; Thu, 12 Feb 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922422; cv=none; b=IpNmDop9On4v9lkBoRnJWTWUveF68YnAmubN/GTzIkGOlMlpdHoqUmAOu5cMKuEw3Utdid2EMGTE4fXu0pYBPnx4GJSHFdqTbWNzqQNJwkkuZIX5hIQlA3SNfLXkf0L1R75KP2PsOGEGNMGACHa+atfXO8G1WwfobBEaB/7qaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922422; c=relaxed/simple;
	bh=8Ldg5BtJnWKFIlq0ZJudFfIkGC7ZR6/KYQaK1K02KQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWdp/fcQJULM1gEErBoVOBMDdFs4l1TDOIdHI6uK+h5Q/jFx2gqsL8Yet4UcnsYVvE7VrNaIDhc9UwvyuhvRttnEf4JqlzR8OC5qIJtNTmogktstB1iOL2mhwNRgqSS3uW0vG5HhWSvYTl5gzf2eIxIHkiXx0f9x5o4XqT6GICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFNoXGR4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eLf34nJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFNoXGR4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eLf34nJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770922420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TpdABHHXmluI87ESBOkKLzcM9NdFtCInznpNKecCj0g=;
	b=eFNoXGR4CyGr+4a2X822l8gs2/HQul9oPfSkQGiZ7CIqqoR6C3ATSPZSvzUHLhg6nUgJhy
	3aT0yndRvsoCtO0g2KKNGRl8y+17vBEUxKe6rr2LFU9pnLtyr41Vx+visOO9caWKd6T1EY
	hwMva5nBABi3Len1NNH9MScWvE/IFl4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-v8c0CEaMPzSNV2w3FuSYuQ-1; Thu, 12 Feb 2026 13:53:38 -0500
X-MC-Unique: v8c0CEaMPzSNV2w3FuSYuQ-1
X-Mimecast-MFC-AGG-ID: v8c0CEaMPzSNV2w3FuSYuQ_1770922418
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aadeb3dee4so5095845ad.2
        for <fstests@vger.kernel.org>; Thu, 12 Feb 2026 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770922418; x=1771527218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpdABHHXmluI87ESBOkKLzcM9NdFtCInznpNKecCj0g=;
        b=eLf34nJcm6qjldj/75d1jH4GB0PyKxc9oyuGwKzRmqrC5zNYNro6MfVSj9cZiRoBED
         UA5AsFulNdMwHh5W1qzQ9568HrSTfvkp6vVGy517mH5hlMUtGWlAFYkbsPBbbjE5Z+7/
         vb8cVAgZZ4tiWlD2m2B6fUwms6Q5xz1znQH4NU4lqudCyqHmu7mRqhx68pBCx56CCSkQ
         AhxiHuyNSSpJBi9qoKpxom+m9H6GUls58TA1LFP3CbL/DpTUEhnT8+I4SoUK8mftDCQ1
         pce9NGwu7VHb9ct4qGKjgWabkuT59/1xMKuo0FXXIwz/iMsE+erLZULzdulf+VlTjF7h
         U7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770922418; x=1771527218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TpdABHHXmluI87ESBOkKLzcM9NdFtCInznpNKecCj0g=;
        b=MGqwYh4+4DAFjCzwOUbqM/Aq4OH0M8s8BvummS3ni4JfGVwqQzzOhSD/Lzgfb9XwXt
         MtErL/u1vPY2ouo1clGMHVQBDhhzEPVH8i45/gszBAfiZrZG1jHFeT38UHhfoAccJbb5
         +42Peo2N4dagzug3n7igL9triFBiqCSMX31E8SC4YFLrKeR39k6LaY0eSbrb7QXuWlmQ
         3iwhhtEdSxem3xZ6DyYZmD3C9APv3iTy2CeD8f+cI5ksO++R+zOjrdj21pEHkwmbn3ey
         P0WnTTLf/K87OUhNUq1Ba/E3jS70Pa/g6VPkEhySjU92sL2C8J+4lWxIOIEWcN9zGz4a
         WJTQ==
X-Gm-Message-State: AOJu0Yw3Xh1krbros4XZmLtFwP1ZD4TFwY6PpzN85+ltI8D8fd0mbuLD
	UnsYqnooR/FnjaOI/JLBnXitJkJPpX60rpUSWgxzBOegji/eq7QJrQ5/U/tB3EMTOAj/Zwukr0k
	F4+SCZBLcRe3KbSLffcB3cnnFcelYtqezlycYaTHx074GwJbVU/dNybGhPiU=
X-Gm-Gg: AZuq6aJpYQkrwRgz0ZWr1XpPgjZElTun3rGVOJNj1yL0BQML0AwBlFHFbPepcXwuzeB
	WHlmBGU6IZ7gXXwNPOedJy41dfz9q0YaUEZLN7lPBkmMsq//rOS3+svs5w75qjNmezltjWK8Jka
	u9ZhTeou5Pf0UD/7RIheLWkDPG71SdPwf/r2uFYP7rlO9jUGaRKeDbrw9FNc4ayTpgJL03wbCYv
	cmZVxeoqIfsrKuCnsL9077+EeZQbLSlgnwqZW+0Dr5y9N1ORgpMCyiOauHQGAZd+Ls0YT9B/WMh
	ZuR+3e2qpNVte/ch+VeyYUKTkEj1AZe/M984F3T7qB72G6OIGYhMH2TlNco3a+zIqU0JR7Mh/IB
	ay61VaPzIQGbi3UAqi9TIjeJ7icN12iySEpWAfaCKzSYwaPFOJhVyU4sqwHtefg==
X-Received: by 2002:a17:902:f68d:b0:2aa:e0d3:cad7 with SMTP id d9443c01a7336-2ab4cfc784dmr93595ad.27.1770922417599;
        Thu, 12 Feb 2026 10:53:37 -0800 (PST)
X-Received: by 2002:a17:902:f68d:b0:2aa:e0d3:cad7 with SMTP id d9443c01a7336-2ab4cfc784dmr93395ad.27.1770922417056;
        Thu, 12 Feb 2026 10:53:37 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2996665bsm84263655ad.54.2026.02.12.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:53:36 -0800 (PST)
Date: Fri, 13 Feb 2026 02:53:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Message-ID: <20260212185332.y7ndgibqix7tmibs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260202132730.589621-1-ojaswin@linux.ibm.com>
 <20260208175443.5h5uy65figlq2y6f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aY2U0YssqaFU_ns9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY2U0YssqaFU_ns9@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Feb 12, 2026 at 02:22:33PM +0530, Ojaswin Mujoo wrote:
> On Mon, Feb 09, 2026 at 01:54:43AM +0800, Zorro Lang wrote:
> > On Mon, Feb 02, 2026 at 06:57:30PM +0530, Ojaswin Mujoo wrote:
> > > Hard coding donor size to 250M causes the following failure in e4compat
> > > 
> > > e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> > > ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> > > 
> > > The issue is that e4compat asserts that the stat.st_size of all files
> > > combined shouldn't be more than that of the donor file. In case of 64k
> > > blocksize, fsstress often creates sparse files which have >3G size even
> > > though their disk utilization is <100M. Since donor file is not big
> > > enough, this trips e4compat causing the failure.
> > > 
> > > Fix this by dynamically calculating the donor file size based on the
> > > size of all files. Also, make some changes to avoid future ENOSPC like
> > > reducing the -n passed to fsstress to keep the size around 2G and making
> > > sure we use the whole SCRATCH disk instead of 500M.
> > > 
> > > While we are at it, add some new lines to make the code bit more
> > > readable.
> > > 
> > > Reported-by: Disha Goel <disgoel@linux.ibm.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > 
> > Hi,
> > 
> > Thanks for your patch, but this patch is conflict with v2026.01.27 :
> > 	42c2ccaf ("ext4/307: allocate donor file size dynamically")
> > 
> > both of you were trying to fix the donor file size issue. Please confirm if
> > that commit helps you. If you still need further change, please rebase your
> > patch on v2026.01.27.
> 
> Hi Zorro, 
> 
> thanks for pointing this out. Weird that I didn't see this when I
> rbeased on master.  I'll test the patch and get back to you.

You can always rebase to "for-next" branch to get latest version, or check
"patches-in-queue" scratch branch. The master branch is lagging behind :)

> 
> Regards,
> ojaswin
> > 
> > Thanks,
> > Zorro
> > 
> > >  tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 37 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tests/ext4/307 b/tests/ext4/307
> > > index 1f0e42ca..7e7fb9c8 100755
> > > --- a/tests/ext4/307
> > > +++ b/tests/ext4/307
> > > @@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/defrag
> > > +
> > > +# Get the total of stat.st_size of each file to determine the
> > > +# size of donor file. We use st_size here instead of blocks used
> > > +# because thats what e4compat.c checks against.
> > > +get_bytes_used() {
> > > +	local filelist="$1"
> > > +	local total=0
> > > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > > +
> > > +	while IFS= read -r f; do
> > > +		echo -n "File: $f: " >> $seqres.full
> > > +		[[ -z "$f" ]] && continue
> > > +
> > > +		if [[ -f "$f" ]]; then
> > > +			local bytes
> > > +			bytes=$(stat -c %s "$f")
> > > +			total=$((total + bytes))
> > > +			echo $bytes >> $seqres.full
> > > +		fi
> > > +	done < "$filelist"
> > > +
> > > +	echo "Total bytes: $total" >> $seqres.full
> > > +	echo $total
> > > +}
> > > +
> > >  # Disable all sync operations to get higher load
> > >  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
> > >  _workout()
> > >  {
> > > +	local blksz=$(_get_block_size $SCRATCH_MNT)
> > > +
> > >  	echo ""
> > >  	echo "Run fsstress"
> > >  	out=$SCRATCH_MNT/fsstress.$$
> > > -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> > > +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
> > >  	echo "fsstress $args" >> $seqres.full
> > >  	_run_fsstress $args
> > > +
> > >  	find $out -type f > $out.list
> > >  	cat $out.list | xargs  md5sum > $out.md5sum
> > > -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> > > +
> > > +	bytes=`get_bytes_used $out.list`
> > > +	echo "Total bytes used: $bytes" >> $seqres.full
> > > +
> > >  	echo "Allocate donor file"
> > > -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > > +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> > > +
> > >  	echo "Perform compacting"
> > >  	cat $out.list | run_check $here/src/e4compact \
> > >  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> > > +
> > >  	echo "Check data"
> > >  	run_check md5sum -c $out.md5sum
> > >  }
> > > @@ -41,7 +74,7 @@ _require_scratch
> > >  _require_defrag
> > >  _require_xfs_io_command "falloc"
> > >  
> > > -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > >  _scratch_mount
> > >  
> > >  _workout
> > > -- 
> > > 2.52.0
> > > 
> > 
> 

