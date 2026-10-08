Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D0485CCF
	for <fstests@vger.kernel.org>; Thu,  8 Oct 2026 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453251; cv=pass; b=utRwHhTWTWgt6Xr5Ms1c2m4JPFdR85HKzdDjWIfv/BOxyO2PmjeUWN4cmlNAEm30cx1zh+0JfGFGyvqIYE9d8KBUWlGhxv6pZJNUWLxBZrMdYtA/MJrYerdCJrWuNkMq6oGegBgKKWSAmFTfP6kit9LZVW0aa1ZPXtElM8Non6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453251; c=relaxed/simple;
	bh=5j67XZGvPDHSMwsxdwk2FIgGT5nG9km2ieTN4dBOqmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDfRTAt/Brk/hHly5fAGdQf9lIPvKJzXMSxUgSVni3kGAJeHa9Dm9IY7KiF0y1LJ9wGxAwaLmw2PhfArrjrDvl5eeTzSk6oy92e1P8V1DQu9W7WyaJwKMY2rz8BxfdXycMMMSqpL0EOXqG3LTUoywS091v8FpDpyupG2c+8ave0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ExhE2/cP; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExhE2/cP"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so256131cf.0
        for <fstests@vger.kernel.org>; Thu, 08 Oct 2026 02:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791453247; cv=none;
        d=google.com; s=arc-20260327;
        b=IoMuGBXFPj6Yw/+s3c+IXxG+Nzdbhq8JbQsOU/4SX7uwQAyZLo4DOzroZajOIrTZ/C
         ykkPjcvKe3hnFcA0k3i2dRKq/gIainUCwutA0geUSLGiq0Abbk+dcQUwfr42/2jKZ9rY
         0wrb5U3pXA7Azs6ONXMbyY5Jh946FlXL8K/2QtCKsn8wP1gWwrvjIXi1gUOKPIdDku8H
         txa80epQSCa62DJdwpYVSjMKA+W/d+aAxhbogFNjYUcbhqBrFDOCqtE/0PwzB1w6eK7P
         Z06bJW/HFcJOAEeAUty3SGETdt7ZG9AhzHHh2QGHXVS4SDPvX9ZeHp2AKAhmzEjAiFMg
         Zfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
        fh=ePxSnanhsdqrg3cLQIgvNkhKKRDLlCcYTP9gSE9mayQ=;
        b=QnNIYHgPTa7DB6kNXRLP0qJ5d/Qfu3hyzW7qxV9FWdyIedaKG8W27D2iq1LoISn2ss
         7MF5ze5z4AKu/LH7c12FwLXAuIOBQO3dMyh0vDv++/RVHv85hi8NvWKSgT6b2NqKWabQ
         hirHCx6nm4S55ISUshOb0Zk8MUx/MO1jnCZXVdEVmDmB8UJGyX1Lzd+eiDataxf8soXh
         fPEV7ue2Ns787RbqOjToA08QZ0GJsROgIgwpQYzJzwEt6IEGwrdzwWvLjYsbc0biUukt
         jeiDUkj+Vm1aATtq4an/xqNgXrFulyPLOQ+877GAoMrkOSKecCNlhYELI4LYx1CjfvfU
         /9MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791453247; x=1792058047; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
        b=ExhE2/cPxiT7+5SMDv6NmkJ1ry4Rtp7aO4CIIQpvWoLjLb8+I/N94nzvWHPEtN2Ufy
         j5GcDk+MKnXrb70UWAJpeZmoomn0BSruDHgvxKMkcrSTsoTVUdNpdaBuhnLt68E8nSqX
         sC4FNVj9bbhLD6mvTHgZs08Xu692fojU1OwBm9GQvhRF88+B1CTenY1XSQHTvzwlpEz0
         bpUe/EHnsWpvK7oIMxLY9LnTizpek7AW1gct1oq591uxhlrc8pFuDnlTculH7WUoZ9UE
         yIxGMvy2A+xX5Mnsrb9faNu4m6ZocwAEagBhGlG1PJOWHK81mFVAfc/vRG/+g1FNAGp6
         FPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453247; x=1792058047;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pfh4IAK+hk+AqpWfVdWMlr9/Ce13+Dj7dKdKxg+Obqo=;
        b=avfu4v2LqzqF3YSkKbhpK5N5EXnGj2+cPeTH9w/Dg0Qqxuem47TiNP+QCXag4OZeHU
         anXb1f4Se1vkL2Vyun8zjuXyWUlqW5j7OldgZl41Hy5dRPBu5iSsgVrmFygQWaEw0qZw
         GiI/qx+VabBXMP0+25kh9y4FxBTwdw+mSWXh7DMtEUkR/zRk+6MgfC/MsikQvdzP7BsE
         NQkJDTn8xqnZavlllXSWOJwzYPErj2kggo5nEOeIJKDjF9HMHEHOtBv3d2vpJWOjp45C
         gDj7V+78JROs64MuHX+OsVTOQYsvTCrJgk/V1zmvD1uuYNIC+aKxEVsCVOishyaaerve
         IEFw==
X-Forwarded-Encrypted: i=1; AKwUvBwsLdApGsGSZGFeCEJ4rKd0CWvpA8RhW356c63dGVILTd6BBJplU572QiqpuN3qSDQVANQOVzky@vger.kernel.org
X-Gm-Message-State: AFuF++mnXPfQvJ3C4k3p0CvCgJ/ozblyufC2cqDd+gkPI5eiwaNMxoVY
	9edCntMmz0wQCPhmrgzjyQwchJsME9pJf32ALcd0MmESqfX8qnk9OiKqB3mmzSosxHpoTOU09ss
	xVVjmc5umfEWsQeOaQoubov8kOATmdaed1L+Qm6KVuNOV+y/XY0ac9XXD
X-Gm-Gg: AYBFou3POFpjh4z1yahWNOzNF/w9BP1NRGKW6sdzyOVPcElamZJ5ttjd1y51yQD46A8
	UP9XOcIywHdhxcTiMdGw+19PPZEe1sxPDMxhQIgqP2AjsBP2NsFBI6Qd50YRz41NhzPLRe7d7RQ
	T3RA4LHpFhtgbZ4TZYT2cOf3Tu3d/fj6Vd9mjRxifK4zr1PhOY7tAkhVijcmFty2zNWIWkPtANO
	FUZdmo4CiA8Wlr3EytW1rO8CZUIEckTi2B18k+4hmBJ8yoF01q+L9UHFCfZUlivddH6PnAQJGiN
	1WDVl4kEooqhyetEHdTpD13hWvmuMPYE5nNPTc9SQKvfBKsOmzcEVjhmpOalPhpIOKkq8kjP9Cg
	RjkUely6bT8x9wg==
X-Received: by 2002:a05:622a:5a13:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-5358a085ee2mr15530731cf.6.1791453246927; Thu, 08 Oct 2026
 02:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008093317.2792726-1-jprusakowski@google.com> <asdkTCwh9hW5gkEJ@infradead.org>
In-Reply-To: <asdkTCwh9hW5gkEJ@infradead.org>
From: Jan Prusakowski <jprusakowski@google.com>
Date: Thu, 8 Oct 2026 11:53:54 +0200
X-Gm-Features: AclHuK-VcO99yoe7ZhiCBiJq7TbGRhqmRi7Ao2zlUaErLuv7hcSeESthDFpmc4U
Message-ID: <CAHwWncjqdUStXZqm5Bv9DD-HGFPvjA5csp5DKT0Mdo3QR118-A@mail.gmail.com>
Subject: Re: [PATCH] generic/622: increase sleep time for lazytime expiration
 on compressed f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

> Please just increase the timeout unconditionally and add a comment
> explaining it.  While there are some historic hacks like this, generic
> tests really should not have file system specific conditionals.
>
> > Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2
>
> And please don't add useless not-standard patch trailers.

Thanks, I'll send a V2 shortly.
