Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724942;
	b=H+oL4KmMTTgIa/tp1SRhclgLI3injMvp25z3W18PAZqPf/OBLIwfJoLiajXeX9i96XB0
	 mJKVfN6ml2ZV7s3UYkPq2ncFPmAx+GUFySN6zyPCMrp7bHQ0c0h/893EJebLCrOxsDkOp
	 B8nAIl7Q0GwR9vsWI+npo8b0xKKICfWbth5WFKKo9ueCEIeR8Revi1G1ZptymU9M8qSFv
	 tSotncKPWIlo39LXNFVPKxmfUtxwuhdOVLCCuvgzl6UCXNItPTR6TIp30/wCkjfwR7Ytp
	 5UT7YL3mTUJdh1mDkAiQPYLWC3wXwp/muGlv4VSAtNMohVb6BrCAJ+c128W3pNgZafA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724942;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kdLL7Yg506/OU3194+lHpPleSU7z2Nbl1xEkWPkllrw=;
	b=LU7FHD3nPbEmPjJPjVzp2ZKNJ/cNyUa/mgfjH0shVnwlDhBKWWgdg1Xnx1kH4NB5sZU2
	 9GMpn+HW6uDD35tnf8psgoO0U/SlPnnP2NPj0oSXnxTlWb2PcA+M2gXQhBgQI59nQDr69
	 SKEqZ95GgAuLeY1czM17+yAuN6EzJZP8LQ+cUXRtdztD2GjE/IWMB4ym83IMYkn1j3SfG
	 +Fp1F7o5B9h0kSVmFHZ7MaA4HIZOKlEdlPiWKNThdLgYZ2lZQTgkfFPV6T3Sd3Ef5zfhs
	 Q90xjEQB8k698uOOxasZNx4cJk2kjZkFh3mOmbGeDleeukbdS8d7fva4F/ugjdj3bkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=4pe3q63tznap5lvaoa7tac2tbu.protonmail2 header.b=LwBPqNbK;
	arc=none smtp.remote-ip=185.70.43.19
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2A606A31E
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 20:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DB2A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=4pe3q63tznap5lvaoa7tac2tbu.protonmail2 header.b=LwBPqNbK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4pe3q63tznap5lvaoa7tac2tbu.protonmail2; t=1795724939;
	x=1795984139; bh=kdLL7Yg506/OU3194+lHpPleSU7z2Nbl1xEkWPkllrw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LwBPqNbK5CHnwqaq+3pJh6dYTdSo0GjllODeqUMHUnCXvhVdBKUyInAUJgYL5tnIR
	 0/zJEtIU1NmTlWgiuNQBHMKRwy5/YCa9c1iEJoJgjCFHVb2gOPo1gvV7TSNbFpEvPV
	 6BfjPnrBjzT6KJN/N1aO0SFOaUI3KPlm2FlZqY/YxPCi7ZWJpw7cN1qE9cFf4ZclKe
	 s8jN3+bU3IHMU/G1qEoUd3uBwlaCUbXOiV3Bj4S9LM9GXYTy/dhDP7gqLslpzsVJip
	 GByaiKhKuUQFz8j3UM6oA9yDgiui12N6t+JfNWdqjV6SbAaQJjO+j1XZxzJ5HH+AQ3
	 CZRHuKh6U8LTA==
Date: Thu, 26 Nov 2026 20:28:53 +0000
To: liubaolin <liubaolin12138@163.com>
From: Ernest Borowski <ernest.borowski.git@proton.me>
Cc: ernest.borowski.git@proton.me, fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>, ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [PATCH 1/4] common: add support for the ntfs driver
Message-ID: <179572492929.403959.7488744115552484847.b4-reply@b4>
In-Reply-To: <2ff07282-cb19-4098-b171-bb0875939976@163.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me> <20261125-ntfs-reproducers-v1-1-0cc67533d803@proton.me> <2ff07282-cb19-4098-b171-bb0875939976@163.com>
Feedback-ID: 236360163:user:proton
X-Pm-Message-ID: 135b13f77f1fbd3df64752fe621ec9e2a7535804
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

On Thu, Nov 26, 2026 at 10:39:24AM +0800, liubaolin wrote:
>    _common_mount_opts() is only called when the corresponding mount
> options are unset. If someone sets MOUNT_OPTIONS or TEST_FS_MOUNT_OPTS
> directly, for example to "-o noatime", that mount command will still be
> missing -i and could invoke an installed mount.ntfs helper.
>     Could we add -i somewhere that also covers explicitly configured
> mount options? That would make sure these configurations use the kernel
> driver too.

Good catch. v2 moves -i into _mount(), which every mount and remount of
the test and scratch filesystems in common/ goes through, so it no longer
depends on the mount options:

_mount()
{
=09local opts=3D()

=09# mount(8) hands an ntfs mount to a mount.ntfs helper when one is
=09# installed; -i keeps every mount and remount on the kernel driver,
=09# including the base filesystem under overlayfs
=09[ "$FSTYP" =3D "ntfs" ] || [ "$OVL_BASE_FSTYP" =3D "ntfs" ] && opts=3D(-=
i)
=09$MOUNT_PROG "${opts[@]}" "$@"
=09[...]
}

_common_mount_opts() keeps only $NTFS_MOUNT_OPTIONS for ntfs. No test in
tests/generic calls mount(8) directly on the test or scratch device, so
all tests in tests/generic are covered as well.

Thanks,
Ernest

