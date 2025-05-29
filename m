Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB32629C
	for <fstests@vger.kernel.org>; Thu, 29 May 2025 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748487616; cv=none; b=oZiV/TIENDSiXHMVqVb9v1E4uI03lmJshhxtFklUKTa5x71VtZsNgQhfnzz60Dkjt0hq/royN4K724Otcca85fVoZ7D9Up0fHbOF6vVRL4MOSBXUSPn9q+CDnBhfdvvOPvxSq5nORVOxTM4K8eSXthyPWKqjjg5qB8b3bQMrQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748487616; c=relaxed/simple;
	bh=4jwz9dykOXSG4DrviZmGzD42jgROTg6GslAB5IwiyzI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oot7yJjGQgoxyuzu/H0iZ6cApmLKuy+HuoFRRUVREQEIDL2IGjje4U1ynBDqGU8om+QEySesoOifohFv2iBAM22MNsdWopdJV7lbF7C+n4xKsC4mHP6It2/cf48pq1eNTlDs/m5QyGHE0dBd/7eaQXLKB+PbDZzhwy8Qjgmfq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbpUGI1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbpUGI1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF41C4CEE3;
	Thu, 29 May 2025 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748487615;
	bh=4jwz9dykOXSG4DrviZmGzD42jgROTg6GslAB5IwiyzI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mbpUGI1kyHGlrTeWwFlSdZVPeY8VWHXoJxhRxmamOlPPOI5J1vL/gi29+6a1gDy2I
	 B7Enxb3H6l7aBmyrsgI9Bu8kdis1Nrt6zPLqAxmuQLhyCXflhFcCmBwdUoVCkhvhSz
	 /Rk8A0TKaGScJ5lZxKiULHacIpPVRk8rq/PnqhLwWIPsprEIIvRlNgv3e5OOYFbAtX
	 wXeI6kSwBYH+ykyxbKz+0Uvaf28RDCCO2w0MyR+bb/SJ4/YfzvX4dBB+HIQcelhgPk
	 jdM8/pRVwLjjhaw6nKzCOwgoTSrD/d31M90yseMdKbjPfEyC2JJc2ZjZBbFgPUCQqf
	 5J+zOKDsY3snQ==
Message-ID: <da22627c-624c-47dd-b3f1-130fbbf7b232@kernel.org>
Date: Thu, 29 May 2025 11:00:12 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] f2fs/014: test for missing 'trimmed' flag issue
To: Chunhai Guo <guochunhai@vivo.com>, zlang@kernel.org,
 fstests@vger.kernel.org
References: <20250526080323.1851300-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250526080323.1851300-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/26/25 16:03, Chunhai Guo wrote:
> This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> properly set after performing the following steps:
> 1. mount the f2fs filesystem
> 2. create a file, write data to it, then delete the file
> 3. unmount the filesystem
> 4. verify that the 'trimmed' flag is set in the checkpoint state
> 
> We should apply the commit ("f2fs: fix missing discard for active
> segments") to resolve the issue where the 'trimmed' flag is missing.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
