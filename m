Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CEA318B9C
	for <fstests@vger.kernel.org>; Fri, 17 Apr 2026 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394745; cv=none; b=gsnjgGZ3ARTcAsTZv4+tRAZ3tsFnq4YoPVnVtdoPttUh6b/3IJyEMyYJh39qhHQN99pI3qQl8IJHRHPDtkYQ0r4Yu3m1RyqNOMk+cZb/FwQZ+o6z/E01kTql8Qy0ejMVvWJKNL8EZHtkHiKzvETPRg9vQbqnuu7oPWcZxNcjp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394745; c=relaxed/simple;
	bh=8coQkp0wolDiPPT+XtdOXRmQ/k5WDstRFadhYQ09xzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlEQll1EmFnKUbEvjLE/F/6jqRlE6KUwT1ypQUknGq7W0aHMFb9Co8cky312Wf8+b/x7uH6ja1luvRfC3f5PsxKwZ4roGTNMg2iNN3JA8jyfF1DWXemdrnF0g62JQGzTIzVVY5elw2pOWO3sExFTuqPoUFRncqvr/43bgQl7RNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5DcyG89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5DcyG89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBBC2BCAF;
	Fri, 17 Apr 2026 02:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776394744;
	bh=8coQkp0wolDiPPT+XtdOXRmQ/k5WDstRFadhYQ09xzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o5DcyG89py/81kWPC/UdGVhotis9beGbsepDHgkCfibi+rkbVooOrnNMep0xiLIfK
	 5s5eRaqJJw0znWaOkz8er6Rhc23CQxkLUdeyn5M9MaEPCn/Hu2YQr8z1oAzc057N8c
	 aaPyllxGpQBIvnfeo3OEVnwwu/bgVbfFMXLFPv4qDpgO9R49NTv5lbH8Tu+Jyk9D46
	 wPpXspwrdj8ZwzVz9dq0iRDPsTmrG4PF69fhp6x3Fd1TXfJxQNMiPu/NWsrOMH86NG
	 jYMXF6Hpi80EGE/lpMpx08CYwbFQCRKL0iWDit4zEyUPP6S0DWjGekBGI2ngtE+T09
	 iavABy1HgAf3Q==
Message-ID: <0c24f215-54d4-457c-adbe-e03c815382c2@kernel.org>
Date: Fri, 17 Apr 2026 02:59:02 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal
 filesystem
To: Jan Prusakowski <jprusakowski@google.com>, zlang@kernel.org,
 fstests@vger.kernel.org
Cc: wqu@suse.com, anand.jain@oracle.com,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260410131821.991005-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260410131821.991005-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/26 13:18, Jan Prusakowski via Linux-f2fs-devel wrote:
> F2FS uses a checkpoint mechanism for metadata consistency rather than a
> traditional journal. Roll-forward recovery is only needed if there are
> fsync'd files since the last checkpoint.
> 
> In this test case, files are created without fsync, so there is no
> roll-forward data to replay during mount.
> 
> Therefore, F2FS does not need to write to the device to recover, and
> successfully mounts on the read-only block device. Thus, it should be
> treated as nojournal in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
