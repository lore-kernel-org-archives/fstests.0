Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724964;
	b=AKF4s6dzcaGq+G40R/kbwevn49GvCLbnZ+5gMbAKTO43Cf0x5j2OHLXtPurc+NkN5g+q
	 Khofp+jVJpupGyjY3X20Gzzkbz0gmcvAbSKBBqwsuyBXplQjL5lZTTjoSInDk6emfcQ/4
	 byn5PTrD/bR6To+u0HyjPyBOU/VQgRLnb+GIqvCEZWyWTMDqj1eJPsWtDlnvLgBSBgImX
	 Gnxgb1FmJqBgGkluMWTbC8t7+2CxKWbUR6d75IoXPXYaUny4ee76X3FuBmkgCelYN/HVQ
	 0i2fhxyRQ1kpI7SlbxGMpam5LmoiJEhSuCJtxracbNWBNCYC76kdfBb1jqhMB77uNRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724964;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=08GIiTm47Cj6zwev/3VfXW4xu+JxsFqjGLFCYOlgTmQ=;
	b=v5b3MkMhYINSEYP+jWZgZ1YMMnMfDRiDGMqyMbOeZc3Gdfw0nZak67Xs/kIKyKe2n8/W
	 mavJFbQsor5lEQ89zIfI/jxUfuwCYdhxk9TFHw7Yqg5M4DUVL36UISnHZl0vO8JL5yC+p
	 7JTrIh+sjYwtDJ5gzlreKGqDm2zhAg3Z/0M4II5KRiEvxrOVuvSUD5+w1fS0bgSZcmGGn
	 M4lzJM5IVawn/WYZsCxcaYBGOXvm+vRQ7dl1frOIfMBmfBTyk6J+hnKU6xi0P3tsztcgt
	 ryWuASb/wKeRXi8BOaXEBgWwzZkRA5pYW9syiRobQBlCt8CXPEPKY+fNfkzGeOZvWUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=kugNLNte;
	arc=none smtp.remote-ip=109.224.244.24
Received: from mail-24424.protonmail.ch (mail-24424.protonmail.ch [109.224.244.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCCB606A31C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 20:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=kugNLNte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1795724962; x=1795984162;
	bh=08GIiTm47Cj6zwev/3VfXW4xu+JxsFqjGLFCYOlgTmQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kugNLNte+4f3A5D6RDNu1xLDt/FIc3/2GEUye9IW90uy0x1l2rzxnRLCcRVUbA8xx
	 HK9WCDgvKHYjY/6PRcb3wF0P2UcOQ3xWEi0GIV4GDhgvxoq5kmK74sncZgzAzN4XTJ
	 HxWbpe4xwyK8l3punE2bW5iMm+zgUZBErcaJ84XMLtTu/hkAGIFMRvX7r4EWqtTbQF
	 uGHwhdGViMRFs4Yx6tSt8ItDlxevTvOI+0JEEEM1J0ZZY3kcDORS7mZ8KVPRb3XISv
	 8QUbAFEOofauAR7rSXHQhGzo2eSLMr+Bl3DOSiiAx6n+BK3OXFxdhHWRwiL5ue1x9s
	 UrJ8UxTuG/FCQ==
Date: Thu, 26 Nov 2026 20:29:16 +0000
To: liubaolin <liubaolin12138@163.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: ernest.borowski.git@proton.me, fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [PATCH 4/4] generic: test a short copy into a hole of reused blocks
Message-ID: <179572495125.405357.254723270878355774.b4-reply@b4>
In-Reply-To: <8e55e631-96e0-464d-b29b-0db2f56c2911@163.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me> <20261125-ntfs-reproducers-v1-4-0cc67533d803@proton.me> <8e55e631-96e0-464d-b29b-0db2f56c2911@163.com>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: 71d218077030181cafe86c4bd5d54aab8a6a81d2
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 02:38:35PM +0800, liubaolin wrote:
> > +for copy in $((blksz / 4)) $((blksz + blksz / 4)) $((2 * blksz + blksz=
 / 8)); do
> > +=09$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync \
> > +=09=09-c "truncate 0" -c "truncate $size" \
> > +=09=09-c "pwrite -q -S 0x01 $((size - 1)) 1" $file
>
>     The later write may get different blocks from the ones filled with
> 0xab.
>     There is also the discard case: if freeing the old blocks causes them
> to read back as zeroes, the test may no longer detect the missing zeroing=
.
>     Would it make sense to exclude discard configurations that clear the
> freed data, and make reuse of the patterned blocks more reliable?

Yes to both. v2 excludes the discard mount option, makes a 512 MiB
filesystem, and fills it with data before the loop:

1. Write the test file and a spare file.
2. Write a filler file in 1 MiB chunks until ENOSPC, then sync.
3. Write a second filler file in single blocks until ENOSPC, then sync.
4. Remove the spare file.

The syncs let delayed allocation release its unused reservations before
the next pass. Almost all free space has then held data, so the hole
gets previously written blocks whichever ones the allocator picks.

The test writes the fill data itself, because _fill_fs preallocates
where it can. It also requires no compression, since compressed data
would not fill the space. This is still not a guarantee: blocks that a
filesystem keeps reserved from regular files are never written.

With the fill, generic/818 now also fails on ntfs-next with 512-byte
clusters, where v1 passed because the hole got clean blocks. With the
delalloc series it passes at 512, 4096 and 65536-byte clusters, and it
passes on XFS and ext4 with 1k and 4k blocks.

> > +=09written=3D$($here/src/pwrite-short-copy $file $off $len $copy)
>
>     Could we check the result here before continuing?
[...]
>     Checking the helper's exit status and requiring 0 < written <=3D copy
> and written < len should catch this. Unexpected errors should fail the
> test.

Done in v2: the test fails if the helper exits nonzero, or if the write
does not return 0 < written <=3D copy (copy is less than len, so
written < len follows). A non-positive result fails rather than skips:
the buffered write paths in Linux (generic_perform_write() and iomap)
store the readable part of the buffer before they stop, so a write that
stores none of the readable bytes points to a bug in the write path, not
in the test setup.

Thanks,
Ernest

