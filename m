Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92432472BD
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997507; cv=none; b=su6jEFGQG0yUeoFwsNMkdjxZUguuweDD+TdeFtFoRW64sU3+yz18K4c7VUgqtdM+uQgjJy99PG0U5AiOPWOEPYRUzGDK0u6KC2Ggd/2w/zSJ4foGMhsapCbgbFSpVcGg9bqLZRoiSdQORQ5+mP4/FzVGJ7RhOu5S8Qu4FeDOxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997507; c=relaxed/simple;
	bh=NSDVSptzf7i7Ge0HQahlbU4z2dWFaYFhyURfKvV8/Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWEYMuEt1BAKerdnSooC8x0naJsnJnb86aRwjPfl2PvV1gz8SqLWg6jncmJGhSU/V9SQ3h5OqqMop+JinVQt5POCQaJFMoMy0d0Tr6+qtbhLM+62PHd+ASYNk0jgIPfAeATy5WEUfbZYMdG7z987VdL+3FKyCJf2fFq55FUcZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmjEa81S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r1GUcmbw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmjEa81S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r1GUcmbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761997504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nzrmyqn1nI6uNvGQvj9+cgm3Z1yHYj1tZgxbuYwykP4=;
	b=PmjEa81So5iEeDMzw7GlPelwHXJFNkNWB+C2gYZ1d3q6jUlA7oFfILagjj+1TFC//E+ARq
	KiZmOrpaHrN/XGgYQ95qFmrzLPLasu5kqouSSLBv7BOtFj0h9d246mv8SQ01+2f2hJSvuj
	Mfv2cBsKR98VLz3hMbsHuKcjtt0fl0c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-9aFpo-qbPI2tp8vUw6z_0Q-1; Sat, 01 Nov 2025 07:45:01 -0400
X-MC-Unique: 9aFpo-qbPI2tp8vUw6z_0Q-1
X-Mimecast-MFC-AGG-ID: 9aFpo-qbPI2tp8vUw6z_0Q_1761997500
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a28ccb4c8aso2881647b3a.0
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761997499; x=1762602299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzrmyqn1nI6uNvGQvj9+cgm3Z1yHYj1tZgxbuYwykP4=;
        b=r1GUcmbwpJihW/3ulm43cyJm0CN5cb/mYlqup7tfVzcZ6oed0kqxmZOMB7XRH/+SzW
         vjrI3fEsPIe67Fpq0iwNE10yJzKY8JGVGojYns+P16wqJVsa6C6gLlgISAp4ZwbuD9p/
         p0UH7PyYNk4yreJ3ZOme0rCZet505qDEP+V1ADyAdlJ2wDkCHd5WSmaRNNRX0w0tbwPS
         QfhzeD6E0F2rCaDnNOoqrX3R26HH+S/Pk9Z/8TyJEMfA8zorNYvOL9JLp60K4YLvCIl+
         p9U2qIMVrMJFe8Kr4FPGXGVFZ6pvVg0lAvCUcXVaT1mD+chH7UqPzEWxhHNyDdLS6DIl
         Dg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997499; x=1762602299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nzrmyqn1nI6uNvGQvj9+cgm3Z1yHYj1tZgxbuYwykP4=;
        b=jwS+/JF/K+1wqyCh7+X4Z/qY2oBxX3Kva7oy890/trBd6vdCN5RwCJJ+uBVYvPAuNA
         5rLZpdHkhEN5aUfZDgN0pUlMxoJDi2TfN7vqCrWXzvMenV1lCfVyjpNk0JcQhOZVqpCn
         H0Tn5wkHc8B/Lk1LNrLFPwVdgoDzrGJnzApwFITdP00DAMC2qK8CBZIYbKZELomF9DyK
         VAAY+7Os8tVSeS8EeCXYbAjsM/cpWxJlKlhh20dytOVKz3OqrgbgiKOGNX65YABX03NI
         GEGoYiwe44Q/+nVqjDT+uPAAgcbB0qVl5KgRkvH8ctW/jmkvMSfDs6QmNZH9KRKL+UFL
         DkIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXKr62P1q3ySY1MAcyMfC9vUJ7KLTw89d0xB1WJAho+kKUSbxXN5FOe6ouwlP2h1jddSJTraMy@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsVdOMAsdKWwLKtxQDeq6CglsjZ1QMeiOguHM1KQZWux7uPld
	gdfZsSZrBCqhgA1SAmB1HV10thRiqxoL4lOn0FOBCciKSz40gZMm8ueTnuSrdkifyoR4SHaq9vd
	oQfyQQt4mepulNHNiTLYQjL1nX5+uPesJyw1+4GtzPYArqOzAIj3wfoTuQe0=
X-Gm-Gg: ASbGncthx0L1i3BgvvtbkibHLPkl/2MsRO+SlLcgwGA/uCuunSSGX709RJfsAE+kqPI
	y7B2tO7jDyF/0/+8Vrble4IaX8HCGYb8fPQ3juQZ2Q3WrvyMrX8zO83f8V8e+b+HszWIofeEDuB
	oSUa5m2xGW+R/dEnBHZiAR9Md9w6JNprIxIYdR4NL/SIiOeSlRoSQjh/I2rPqplsPfxHFTmXmfK
	HgXbQ8BhhnNa9bUyJCKTRwjM7pBynSASAPv8RzgjeDr8/CkzekAwy0wAQaECPgpEVmgXAdkqapH
	DOtPzGqiruJst9JdCM18Y/7MG4kAKD9W/32lYZtKVC/VgoeCgoYmcZhNa1r9uVzWSsDaPoMn8oT
	vPDwLNiN6f+L01Wy2lKo8PVH1aPDtajrzB9B+uXQ=
X-Received: by 2002:a05:6a00:94d5:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7a778fde6admr7949813b3a.16.1761997499565;
        Sat, 01 Nov 2025 04:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt3t3fILpedWMF3In6I/dloHs0p7vCAoOXOnw4OeJ3kdTZLzsy0qIzhKVTRadsKVjYZDbSNA==
X-Received: by 2002:a05:6a00:94d5:b0:781:1cc0:d0ce with SMTP id d2e1a72fcca58-7a778fde6admr7949786b3a.16.1761997499072;
        Sat, 01 Nov 2025 04:44:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a9bad978c4sm336030b3a.13.2025.11.01.04.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:44:58 -0700 (PDT)
Date: Sat, 1 Nov 2025 19:44:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs/022: fix to run testcase correctly
Message-ID: <20251101114453.g6fxupmriauxtroc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251020023108.327728-1-chao@kernel.org>
 <20251020023108.327728-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020023108.327728-2-chao@kernel.org>

On Mon, Oct 20, 2025 at 10:31:08AM +0800, Chao Yu wrote:
> f2fs/022 will report failure as below:
> 
> f2fs/022       - output mismatch (see /share/git/fstests/results//f2fs/022.out.bad)
>     --- tests/f2fs/022.out      2025-10-20 10:18:47.075968669 +0800
>     +++ /share/git/fstests/results//f2fs/022.out.bad    2025-10-20 10:25:20.000000000 +0800
>     @@ -1,2 +1,5 @@
>      QA output created by 022
>     +wrote 8388608/8388608 bytes at offset 0
>     +8 MiB, 2048 ops; 0.0018 sec (4.300 GiB/sec and 1127132.6362 ops/sec)
>     +fallocate: Operation not supported
>      Silence is golden
>     ...
>     (Run 'diff -u /share/git/fstests/tests/f2fs/022.out /share/git/fstests/results//f2fs/022.out.bad'  to see the entire diff)
> 
> HINT: You _MAY_ be missing kernel fix:
>       xxxxxxxxxxxx f2fs: fix to do sanity check on node footer for non inode dnode
> 
> Fix this testcase as below:
> 
> - fix a typo "$SCARTCH_MNT"
> - fix to update output to "fallocate: Structure needs cleaning"
> - relocate output of "$XFS_IO_PROG $foo_path -c "pwrite 0 8M"" to
> $seqres.full
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/022     | 8 +++-----
>  tests/f2fs/022.out | 2 +-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> index f6d77c96..728ef4e8 100755
> --- a/tests/f2fs/022
> +++ b/tests/f2fs/022
> @@ -24,15 +24,15 @@ _require_inject_f2fs_command node i_nid
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
>  
> -foo_path=$SCARTCH_MNT/foo
> -bar_path=$SCARTCH_MNT/bar
> +foo_path=$SCRATCH_MNT/foo
> +bar_path=$SCRATCH_MNT/bar

Hahaha, I took long time to find out what these 2 lines try to change:) Thanks
for fixing this.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
>  
>  touch $foo_path
>  touch $bar_path
> -$XFS_IO_PROG $foo_path -c "pwrite 0 8M"
> +$XFS_IO_PROG $foo_path -c "pwrite 0 8M" >> $seqres.full
>  sync
>  foo_ino=`stat -c '%i' $foo_path`
>  bar_ino=`stat -c '%i' $bar_path`
> @@ -48,7 +48,5 @@ _scratch_mount
>  $XFS_IO_PROG $foo_path -c "fpunch 6984k 4k"
>  _scratch_unmount
>  
> -echo "Silence is golden"
> -
>  status=0
>  exit
> diff --git a/tests/f2fs/022.out b/tests/f2fs/022.out
> index 394c6a7c..5307e3d7 100644
> --- a/tests/f2fs/022.out
> +++ b/tests/f2fs/022.out
> @@ -1,2 +1,2 @@
>  QA output created by 022
> -Silence is golden
> +fallocate: Structure needs cleaning
> -- 
> 2.49.0
> 

