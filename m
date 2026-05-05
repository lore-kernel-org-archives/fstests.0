Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21848CFC
	for <fstests@vger.kernel.org>; Tue,  5 May 2026 02:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777949211; cv=none; b=pZOaSk0y26WFV5DUkTYm6pZoFuak0bVuh0uDlJoBJ8dkQ3cbBwxImCtiIp+I1Ol5i687ea0iSsC19WqTKoZLEL5/WIVsfS99plFeC5WPgHIQzR90ulUFTpzmBKnq66VCzGl3VSVuIZSp8tjmk/VMjuMFggIe+nWlclWs5Ypk6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777949211; c=relaxed/simple;
	bh=Z4kTRZ2r12OryCyS72dx+hC1M/Zxg/SGIK9YkINoutA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkcO+zGc72Tda7+KTG49fWJGMMZMIxSyB+kN8vtDl4TP7XSzb2JfWYChyu+ubM1Nun0IdT/P/n7/DYiAGVCSATtWhdV3VH08DMugi4fZT1dA/XlEmUMlb/N28K+puzTjsCzcmlahCzcMRInWi9WifVFd3PH4SrASWS+I/nvCVh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF91phil; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF91phil"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-364c5317d67so4823455a91.2
        for <fstests@vger.kernel.org>; Mon, 04 May 2026 19:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777949209; x=1778554009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COUQj9QfsRLvAbASLl0T5cf2IMgnwG1oYoIBEIKWwUo=;
        b=WF91phil2nn3yZU8g6WuJeVSbW5kcKUhBP1G7npV2HEivOuobah1ycSbexPt6PT8sP
         1EXiF5sWE9BYmpYkLsDVCAzaLnnplAs/bq8XR8ifIaY3hXXL5ZtVbC+eitQBRLRy17cb
         OAWHjhzNpq4enWKSK5dMkbuFqN+sI6Mhjzc0qxuoxgNL4Uxu5YoWcaA4rsijfn4HmGJL
         77K+ooymKJSScjsVYFZ/NH4f5HdX3ggMqOPgcNZkGe9AZPdLxWFNu429ctj8ib2uK2px
         SQpA1xzCBEkS6vtzRxv5k26yh/HBgIkpqUwBy/QpygNvb5Rz7OVQzwqgLQlEM1tLTYQ6
         l5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777949209; x=1778554009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COUQj9QfsRLvAbASLl0T5cf2IMgnwG1oYoIBEIKWwUo=;
        b=tHke3/tuRp5d92ijxp8SroeaiNMJJIB2kmzAaXpsXHsHkSW6NMYoAq7jzUgj/lFA28
         c6GDwGj7+rUIxZKxFN3HtD5NA9lo1bZTiLfdbhQF3+TniMIrtcCW7S0LFbd0ALOpfzS8
         VUjkhKiPnjMTU0eHhYCQaeWyjqbhAeRRFgtJ1yxM2wDFFlt65hmGFlu27I7OFR9Cm/q6
         h8KPJW75IlNxCQso06l3ie+Iw0X5ZlVMCYXxLvWbjqy/vbTPxtgtLSjf9jDFXjYqQx/s
         lrthHOj+YAK03zwnQ9zEbfl2q1Lz5tiy2g4TwfjXJxhFVyNka2TrzwblHbZvL3lmmwDt
         G1Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8kuRvV5b/v7cjyb+wjnRGP0hsF0ikVEePrIHhAqjBoSix9RVJZBg0mZwbes5ngJz4jlphy1xlJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFNR+p7TKNnTMkGgBwsd3cN+LPFGxVFYL+UNziIHAM+Lz/xms
	OQSksyskF2PW5vQL+me2suG0i79zlosZjCAH80MoBKEO5/9rql8H3vYK
X-Gm-Gg: AeBDiesZ+4Pk/n2OxQJW5aR6WtHafqZ9JvSMa2rjuhPq+14uoNXXCtzd53FKX2vHMBH
	g9XheFbyN98qk4iTVw105NiV694ukdzwwitRKrhnUBinKRULdbYRttr70M+2iYkmCMrejXItVzM
	VIAtVgByi3QizeN9uWjBeT7yv3qFQn1GHaWiSMPhfCfJWvv4lKw/Bp90jVRFUOkMBeYjuh5yu7V
	Ogxe9wgGjEHOs5Iir2dcR0Aycq9n++bKc8mSO7Ls18/9Kd9GZLEhC2cNbIc5K0tcxwEwSwDgo1t
	GRs0HWpQ0vJq/9pNCDiVYAz8zAA5DgmcdtFR2gMJuZEb5IhuYBodAWW61sRxZQYeeXZOsag7J0M
	wqe2Ny3fqKnOQKx99DY9sUNirOlssd2zOrrQN1GboY75VRIHGfLhUvWRbFt197wSVXZi6bfM3KD
	zoq7IPVbfeR7t7/piS7aF3L64kDOcQcgq3EkzF1w==
X-Received: by 2002:a17:90b:4fc8:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-3657737bde3mr1481663a91.6.1777949208615;
        Mon, 04 May 2026 19:46:48 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3657848a750sm402818a91.5.2026.05.04.19.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 19:46:48 -0700 (PDT)
Message-ID: <33433bce-e071-4f88-b0f0-9f5299714d3c@gmail.com>
Date: Tue, 5 May 2026 10:46:43 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs/291: fix state transition logic and add size
 requirement
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <20260427122551.71696-1-disgoel@linux.ibm.com>
 <20260427122551.71696-2-disgoel@linux.ibm.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20260427122551.71696-2-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/4/26 20:25, Disha Goel wrote:
> This patch fixes two issues in btrfs/291:
> 
> 1. Add minimum 9GB LOGWRITES_DEV size requirement
>    The test creates LVM snapshots at each FUA point during replay,
>    requiring significant space. Use _require_log_writes_sized to
>    ensure sufficient space is available before running the test.
> 

It also depends on the SCRATCH_DEV size; the fix fails if SCRATCH_DEV is
 10G.

[  173.478493] BTRFS error (device dm-3): device total_bytes should be
at most 9663676416 but found 10737418240
[  173.482763] BTRFS error (device dm-3): failed to read chunk tree: -22
[  173.485457] BTRFS error (device dm-3): open_ctree failed: -22

Thanks.


> 2. Fix state transition logic for verity enablement
>    The original test assumed orphan items would always be created
>    during verity enablement (state 0->1 transition). However, in
>    some cases verity completes without creating orphan items,
>    causing the test to fail with "expected to reach verity done state".
> 
>    Fix by transitioning to state 1 when either orphan items exist
>    OR merkle items appear, handling both verity enablement paths.
>    Also improve state 1 validation to only check for cleared merkle
>    items when measurement actually fails.
> 
> The test now correctly handles verity enablement with or without
> orphan items while maintaining crash consistency validation.
> 
> v2:
> - Use _require_log_writes_sized instead of separate _require_log_writes
>   and _require_logwrites_size calls
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
>  tests/btrfs/291 | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/291 b/tests/btrfs/291
> index 122aeaa5..ac1d192d 100755
> --- a/tests/btrfs/291
> +++ b/tests/btrfs/291
> @@ -36,7 +36,7 @@ _cleanup()
>  _require_scratch
>  _require_test
>  _require_loop
> -_require_log_writes
> +_require_log_writes_sized $((9 * 1024 * 1024))
>  _require_dm_target snapshot
>  _require_command $LVM_PROG lvm
>  _require_scratch_verity
> @@ -129,9 +129,14 @@ do
>  	_udev_wait /dev/mapper/$vgname-$snapname
>  
>  	orphan=$(count_item $snap_dev ORPHAN)
> -	[ $state -eq 0 ] && [ $orphan -gt 0 ] && state=1
> -
>  	pre_mount=$(count_merkle_items $snap_dev)
> +
> +	if [ $state -eq 0 ]; then
> +		if [ $orphan -gt 0 ] || [ $pre_mount -gt 0 ]; then
> +			state=1
> +		fi
> +	fi
> +
>  	_mount $snap_dev $SCRATCH_MNT || _fail "mount failed at entry $cur"
>  	fsverity measure $SCRATCH_MNT/fsv >>$seqres.full 2>&1
>  	measured=$?
> @@ -143,8 +148,10 @@ do
>  	echo "entry: $cur, state: $state, orphan: $orphan, pre_mount: $pre_mount, post_mount: $post_mount" >> $seqres.full
>  
>  	if [ $state -eq 1 ]; then
> -		[ $post_mount -eq 0 ] || \
> -			_fail "mount failed to clear under-construction merkle items pre: $pre_mount, post: $post_mount at entry $cur";
> +		if [ $measured -ne 0 ]; then
> +			[ $post_mount -eq 0 ] || \
> +				_fail "mount failed to clear under-construction merkle items pre: $pre_mount, post: $post_mount at entry $cur";
> +		fi
>  	fi
>  	if [ $state -eq 2 ]; then
>  		[ $pre_mount -gt 0 ] || \

