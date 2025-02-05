Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483FC1FE479
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738716278; cv=none; b=VZO/ppsOzCYWdjEIConsssVwVWqH0DN2PqWUPgtrKlD9OkEpSCkKhut4lg9N9wKARnhr9YYJk4JHUq9/+E5Ame72gMXxYtoMPkwzC3DgO6DG490NhXzy+YDm51EdxBl6cVy/qdMatDbwBLJbMOmRFgx9Kno6ipu4lWjsWWxv+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738716278; c=relaxed/simple;
	bh=pVwcbcQv1YyjKzLqh4R9W2H8jCN4OFAbje3WYYAvJiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb0CCEXCV+Fiflw+/n2IQWxCS3dGgJEm0DgpbgjOyX4Q9ByKPpBqizhHdSxpgMnjYAxjYvIT8X+OdnTeHrG3PYMC6TTdaQscUkXleu4GwMA9DNs6HlBI3HUT+RQHZ1OnXDmQOKaCAt2sY2ZFQ1VPf/8M2q0Ot/EMmD/q5OR8iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=V5MwExqq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="V5MwExqq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so121127745ad.1
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738716276; x=1739321076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RffbSUq7Mb4CXVvoaSPP7Q/PUJaOswOKzvdfco/hHvQ=;
        b=V5MwExqqnEMTQohuNimx2wnoQzPgU4QltKVMlla2oaP53Rxvy9pvBP9QGeZ1AV8Gyx
         uPtiyW2vGc77WmTYWy/GX/TYXql767z1TcNFFCg36DlRrQjce8A+SRaSDunEomMl4vvb
         QLvMl3LnVIPg93wDhL/cBbQRgK8LCJdii+1rhQSbDvp2PD1tvhx8gNQq+t/p7TumPTFO
         c+S2sAhAmNsZRSwRW16WylR1BMaPdkcfaIlN+Vg/w1O+D6a9Ox5QJiKdzN/ycggPG47m
         yPnmLvhqaiEJ33NK0ObqMjBgZgjmpjEwbPYnVvAG5FEt5FGEjZlEPgKl/U5qIsdw03ql
         jyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738716276; x=1739321076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RffbSUq7Mb4CXVvoaSPP7Q/PUJaOswOKzvdfco/hHvQ=;
        b=hvADQ+wgZhwOQBdSvhinUTV05Zk8mHdcgDvDmWiyqfgTjIG/myBNxy2EyHuFITo7fa
         3EgPKp8p++A6LvTLWW5gz8g9tu5ZG1SMfhzS5zj/+30OFtPQZOmc++4twv0EMlv61nfn
         +JeJqNlYVQBz5zjKVbacvLYPkR4ZD/dHvuWOFlj5ErDPFPtKMt+64NMFEIE+GvQfWe5x
         Wr5zqqAWx68QKQpZQ8WLsafXM90/1eptyshvyPJBsWEuuKE0iAmQobBHfG25cSZXeXE0
         xZlPlMr8iopGztSEu6c7mzQNf65+PBEks1Y7/jWXR/v5WJ+DdMCN04n50O+OdK6AdYFE
         gNHg==
X-Forwarded-Encrypted: i=1; AJvYcCXgUorQV6bWg4x8fa8UQ/K3aaEbqg2gDxurbPx0cHotZI9H9BCIUj+qgm4GBwRqPrkH1Be0Qrlx@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOch7sqxE59ZIczzmghtNObg04jjqAwarVFb57LDgX4QcoJPg
	ZZKsa/Lg2/ImLkOmdo5n3VWwzh4OVtFzd+xtY4FL4cXZDvHftlfmDY1BVqblbnE6zIRa46FzpZW
	X
X-Gm-Gg: ASbGnctb3KrL3ouQP9eEamNqYDAEg2ihN+KE2AZMRLeKuOT4gz4NB8mNJlyibG5DvkV
	jhkfuzkh9TYxMrywj/+Bde5sI1ZwrdLLQA8FlmTENeQCKFh1IRECXYy2Vr24P/4dD5SrzYAEV5U
	ZQ20kk5Rm0TpCnntY47Ng6ENBqliKopLcS001aKYvqBn0LGwEqnvq2GDU8/waUiQxK9ebc+0sIq
	hNktP0Zmm3csyYtHzegLYgtrM5n4pVdqjU2hyLRb8Du63zqHBBUtWORpPP9jNK3EgknUktoOwak
	gACMHOaYi8J1Q/GK87+6eEFJbArZfqLbjqTiER/7OFfRI6NgzODjRXco
X-Google-Smtp-Source: AGHT+IEhKSwpLYzPu4QRekgpin1CFdbsdE0ayHeI6NAJn1J2Zyn36Rb4p17Kg+OzteJjP2Meu8yV+g==
X-Received: by 2002:a05:6300:668a:b0:1e1:94ee:c37a with SMTP id adf61e73a8af0-1ede883b7b3mr1333827637.15.1738716276600;
        Tue, 04 Feb 2025 16:44:36 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424efcsm11177632b3a.41.2025.02.04.16.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:44:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTWs-0000000EjOQ-0KVK;
	Wed, 05 Feb 2025 11:44:34 +1100
Date: Wed, 5 Feb 2025 11:44:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 24/34] fuzzy: stop __stress_scrub_fsx_loop if fsx fails
Message-ID: <Z6K0cg6OOZhntkf2@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406473.546134.15374973350883945437.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406473.546134.15374973350883945437.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:28:34PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Stop the fsx scrub stress loop if fsx returns a nonzero error code.
> 
> Cc: <fstests@vger.kernel.org> # v2023.01.15
> Fixes: a2056ca8917bc8 ("fuzzy: enhance scrub stress testing to use fsx")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/fuzzy |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
