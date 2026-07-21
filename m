Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1D46D57B
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678197; cv=none; b=s5NxCiVmXzIhOz/zD19h7e3StIcMkHKNmWo7Od+tp9n6M5Vj2ZI36JatoufaY6fGyM0kIPwPfXpMQK/MebfW5LviJjlXrVTTYnUJDRTMk2SUBN0lhUPKMyPhUNDrKzkiBQreNg3ljDNHadji2FOOqLUO8jVppd4ZEFHiq6ABxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678197; c=relaxed/simple;
	bh=9ODmXaV/U8KXWQHBgprbFO2NIh4aysr9x+pPq6SSp/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hLJk9LbZAv0Gdxmj2f4s5w7WRAu1PM3a/kUWnAI7uRRDndGvtyYuMgiC7TjZGaUqiu6c0MfmyfeARw9vzOxOmzwS8dmcLBt/WBOvDsbkJ6iyPWixqGFdl5I/wS1zHssVU0uEifIVM6xX8Ne/zyYU6Eo1QNhhU3g9VdLPm2eCrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaYCmKT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaYCmKT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A661F000E9;
	Tue, 21 Jul 2026 23:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678196;
	bh=qyvSwR8kTyehc1+zjPruM+M/dAC6YJuL0NpDJdvfp/A=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=FaYCmKT1GS9xfmEt7bTsprTluroGYxVL4Dy+TwZXYrTJyqwXOYJiKv4LEDLxVW2Gh
	 hp+pxpeHgdJyJVCQBuJBqVbQNSA2fyZn5Qg4IiWt2vIdVxWwnSFFf8rIdboxnpDvvm
	 PygL4rrLqexE4qnAdt6NFRexLR+iCLvoAXRaICaDTDx1RotmXQfOLbbQS0i6OCR8Nd
	 XZ9kgFzoCd2anNnsPHNhVSc0QhS3IUEetCBA/xL83oQBZMaNRIh2hAJafFFkPI4t/v
	 7EfSvsdk8/o9x4y7PkfJjFTSlmt+PFeflczqfq7cfEbPpeKNjznz5kAqSRgMB8zZFi
	 i7w4alefqcnvg==
Message-ID: <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>
Date: Wed, 22 Jul 2026 07:56:33 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
To: Zorro Lang <zlang@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
Content-Language: en-US
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
From: Anand Suveer Jain <asj@kernel.org>
In-Reply-To: <aloCfjjqesxpzL9z@zlang-mailbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Hi Chao and Anand,
> 
> The *_fs_sysfs related helpers were brought in by me in:
>   commit 2a7b77abcd1dde735186b363da24540706c43b73
>   Author: Zorro Lang <zlang@redhat.com>
>   Date:   Tue Jul 5 17:30:24 2016 +0800
> 
>     xfs: configurable behavior on errors at unmount time
> 
> At that time, I didn't think about the "features/" directory.
> 
> Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> family of functions shouldn't be restricted to the $dev directory,
> we should remove this restriction.
> 
> Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> helpers which call *_fs_sysfs(). Also change the test cases who call these
> functions.
> 
> Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> *_fs_sysfs directly).
> 
> Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> them is somewhat confusing and easy to mix up.
> 
> I need to write a series of patches to clean up these logic. For this current
> patch, we can start with a small-scale change first. What do you think?
> 
I noticed some duplicate code that needs cleanup.
Essentially, I think we can maintain two sysfs check helpers:
one that involves mounting the device, and
another for module-level feature checks.

Thanks for the help, Zorro.

Anand
