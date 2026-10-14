Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BD2EEE75
	for <fstests@vger.kernel.org>; Wed, 14 Oct 2026 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975159; cv=none; b=tvAc8IZsBF8lYtBD74+Enb5J18FUbC17Ea7/fPAZXBMFGrWd+8q/sHwutTKBom36Aotxq/xWkUXXDw3jKypK1+/IrP719PNcgf/rdSuPtLtfLq7WSdUSYN1nq/BmMCpu0YAP3xQa1Q1HRSBXdPwNrJDYKdAvJ1UBDXtmA5rtiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975159; c=relaxed/simple;
	bh=2/kcpbGUDnKiv4DFOjNHN9waVBGIACOJTmiJNfTnOEQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZScIdCHIYGO5XbY3wAexA7NV1tFwIM3ErZoT3ELNX370RricosMym1uwZhUmO1orNBXbsNRZOvpdLq5XsSrSPU2N/xWFdim1RHHVXQ+4D1FIAOCRIXOOMDtucBnnXACoCjhiZm6JrUPFuCLj8SBAPko60Cm6uU4s1I4crfktpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTcwNe8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTcwNe8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55811F000FF;
	Wed, 14 Oct 2026 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975157;
	bh=NKhbfG21Z6/FzNEFvz7vS0kzsDAM2Sa2ghF/D3xZUdc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=XTcwNe8/SMQO+bKr4pfjj/+Hq6GM3fKAgAd2rALloMVNC+n/a52y2yhIQN0GJhNlW
	 wRz7LgZWxo2yw5Anuhb0eMVaTTpYXHZvHw1VbZmujYztSTd9+iWUeAsYxwWtRuWxFi
	 oBKv5IYODoYbE7E8FOIBOkKoswkNE486l06CmySiSLHZ1+8mMCbDe6XO0C6fEqwszp
	 IAoGKzsZ66hMqZCibC7EF+SjM/TRaF2RQAs/4OdtbdpowXuKoSMb77r3zKTZ+VU6DQ
	 78XQL0DVPy5Sc8QEr1qfLkkGpCXu4EdHwy4xCqfm7xqVqsjzqnBTqkZPLUh1kpTjjC
	 QbvUAePLdepuw==
Message-ID: <320a0790-c6fe-4da9-bb77-4490e88946ef@kernel.org>
Date: Wed, 14 Oct 2026 18:52:35 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] generic/622: increase sleep time for lazytime
 expiration
To: Jan Prusakowski <jprusakowski@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20261009085544.2450966-1-jprusakowski@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261009085544.2450966-1-jprusakowski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/26 16:55, Jan Prusakowski wrote:
> In generic/622, expire_timestamps() tests whether lazytime timestamp
> updates are persisted after dirtytime expiration. It configures
> dirtytime_expire_seconds to 1 second and enables continuous writeback
> of dirty inodes, followed by sleeping for 2 seconds to allow the
> asynchronous VFS flusher thread to expire the I_DIRTY_TIME inode,
> invoke the filesystem's write_inode callback, and flush the dirty
> metadata before the test executes _scratch_shutdown -f.
> 
> However, on filesystems or configurations with higher writeback
> overhead -- such as F2FS with transparent compression enabled, where
> compressed files cannot use inline data and writes use out-of-place
> updates (OPU) with higher latency in the compression and writeback

FYI, I encounter similar issue on non-compressed inode, so v2 w/o checking
compression makes sense to me.

> pipeline -- the 2-second sleep window can occasionally be insufficient.
> Because the inode is only eligible for expiration after 1 second, only
> about 1 second remains in the 2-second sleep window for the flusher
> thread to schedule, expire the inode, and mark the inode page dirty
> before restore_expiration_settings resets dirtytime_expire_seconds to
> 24 hours and shutdown occurs. If the flusher thread is delayed, the
> subsequent shutdown checkpoint ignores the unexpired I_DIRTY_TIME inode,
> causing the test to intermittently fail with:
> 
>     FAIL: lazytime mtime wasn't persisted by expiration
>     ondisk_time (...) != expected_time (...)
> 
> Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
> to give sufficient margin for the flusher thread to reliably expire the
> lazytime inode and dirty the inode page before shutdown.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
