Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6FA3D16E5
	for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776858693; cv=none; b=ftWWzgIBlxHq0i1+NORaF0mhoB8rQN7zZ69QdcHl6AOrKJ0owy1h1zX5xIDbtJwRX77uWt/bQL250x9xBDdM/nh8nb0VIfwSReYpJ4SBBs3L77rk3458a1GJvvJVSoxP5G9GUK5NV3F4VB71hxB1OU58WhhcyEezdLQFbUMKm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776858693; c=relaxed/simple;
	bh=XCRMq3Jl28lb7xVzh6vJ99+uZ69SG+aN/hdMvbNBYVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlGsGkIyY1FrIRkS3PaSbIzFzu61wlIywTu2OjeAmK5D7OIp/SsPGsL980BRDN9wkgEJ6iMiRt84wzUYg3zxWd2hXckNwUADYDnxFzOzPw9jYHsnRcoeZ8grrrCmsn67LUrMMxxMDvadtfVVrsBXYPuwzmHmg2fHp7C4mQHcWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OklNU0x0; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OklNU0x0"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76c60c7502so2339596a12.0
        for <fstests@vger.kernel.org>; Wed, 22 Apr 2026 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776858692; x=1777463492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/ZDMUKz4uhk7JHfTz2NQ2cYjK+SrQpOAZldlPX+P6I=;
        b=OklNU0x00YVMKRZ/+OGO+qSdzxmMqmBbMVR138mlg7rYefDAkrydtF39KKbtrRUpi2
         PABvkdCUSw+H7eCUvY4C2vcdUyW/E33+IZGWltKe2BUc8mh57SYJsBP2cZVnHgg8Fu5U
         cIqscv9kv8KeeNFoQBls20CpXwf+0p6xVqu32LmlAfj8GBrgkpW9xm5cR8ufIEhLmly6
         /30LEIOy3NsgKe6s1mWPG5ACai2bflGm1A3H0z4MdkoI4zToAfYBXuHjsM5t5r06bJ+9
         sszpCTbfK2g0sNndO9+PtSg+GA+Wmv+34867yYk9eTe0i7sqgf86JvgmHUMPww7CyHhm
         HKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776858692; x=1777463492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/ZDMUKz4uhk7JHfTz2NQ2cYjK+SrQpOAZldlPX+P6I=;
        b=BmraxtGIFQiMImSm+KL9/UzY2VLM0Dii3zWDmPApyUwNhxsq1IcQjMY1MB/zgdmxTu
         IprRtX60ZK2Nms9kLXG+eHxSkD/vRArJwhJE53z5CYUdvbAYQwq/CxkWfAqYf2TuxVKb
         qnLzVmhVsvk9/P4LGpGI7/N7vfUYfUaPvoRo//mnvqDpCWda6OFvT1r8t6o1kG0k7bcB
         Q1Ty9q0LdIUpilv0TSoQymqMdqU2sUT3RYs3JJWymmuloAyygC6lMZtvkkgZdAjHBWvd
         3MSRT3q7j3t6KEQMdM9nHNK+/vR7ydU3O8OyIBxUFwBmAGkaLUzla3FcRZfQTR9VwmsV
         gKLA==
X-Forwarded-Encrypted: i=1; AFNElJ/J4wXiljbHIU+D8R3O13zMDD57jU9VmoDyr6yfJQObvYxHXXzF9qBRkVJKSXt1CvRW5KZGjJiv@vger.kernel.org
X-Gm-Message-State: AOJu0YxjGJEekipJcUauZ6Xsv9/Vb809FcpJIlDsCaX4yt435WHrEXaO
	SFV6VyujpzGQ0Eqz+rdHXLH7+VhgwlImj1RGvkFUvt2/f3tE2EfTjHKf
X-Gm-Gg: AeBDietx56OOp79OT7YV+z/xTQtlv8FyqCnzNTbLCEq/dqg18QGdtzEySrDyM56QkN7
	QJXq23wkGDvSd9TuAeXFS27quP0PKJm863k64BOB7K25Fhm9KugcOwTUuaFUc5guLhS29z1jZ2W
	3KZqoEJcuEc9KcaMvE7UbWU4ZO9AvvFnNDQT48VRguxrY5QssICGq3WF80N03uox7L5oLIATYtW
	702j+5oBH7ViI9TsAZRIN2zth3J7KyV9g7BaKYJd+/wZ5jFbfsdN3ud790WLYKvC27BJ3PHS6WA
	zpaiOZwDokdMmeGUXdyiOIO/RBIbnzUvFnndn5QAztOCJLe08V4AusOcAYWH7MCRAbmMoH8JgPr
	yoYbgGX/ajhlmZt9V06r538TDewhMiqDk15ioHzdDRYMIUPkwl9jjpPxp+w/sSss8XeAhTfXfeW
	z9qHFMmPFhe2vLRFW3UzC00cklTJxqKFV6CSwQ0w==
X-Received: by 2002:a05:6a20:7d9f:b0:39f:3559:750d with SMTP id adf61e73a8af0-3a08cca99ddmr19877598637.31.1776858691628;
        Wed, 22 Apr 2026 04:51:31 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701afeesm12385720a12.15.2026.04.22.04.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 04:51:31 -0700 (PDT)
Message-ID: <c27c678b-89b2-40e0-9b12-23b0807f74ed@gmail.com>
Date: Wed, 22 Apr 2026 19:51:28 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/dmlogwrites: add _require_logwrites_size
 helper
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <20260414102031.74527-1-disgoel@linux.ibm.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20260414102031.74527-1-disgoel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/4/26 18:20, Disha Goel wrote:
> Add a new helper function _require_logwrites_size() to check if the
> LOGWRITES_DEV meets a minimum size requirement.
> 
> This is useful for tests that use dm-log-writes with additional space
> requirements, such as creating LVM snapshots during log replay or tests
> that generate large amounts of logged I/O operations.
> 
> The function takes a size parameter in KB and skips the test if
> LOGWRITES_DEV is smaller than the required size.
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
>  common/dmlogwrites | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index a27e1966..1ce2b2fb 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -14,6 +14,15 @@ _require_log_writes()
>  	_require_test_program "log-writes/replay-log"
>  }
>  
> +_require_logwrites_size()
> +{
> +        [ $# -eq 1 ] || _fail "_require_logwrites_size: expected size param"
> +
> +        local devsize=$(_get_device_size $LOGWRITES_DEV)
> +        [ $devsize -lt $1 ] && \
> +                _notrun "LOGWRITES_DEV too small, ${devsize}KB < $1KB"
> +}
> +
>  # Starting from v4.15-rc1, DAX support was added to dm-log-writes, but note
>  # that it doesn't track the data that we write via the mmap(), so we can't do
>  # any data integrity checking. We can only verify that the metadata writes for


_require_logwrites_size() should be designed something like this

_require_log_writes_sized()
{
	local size=$1

	_require_log_writes
	check $size || _notrun
}

So, patch 2/2 can simply call `_require_log_writes_sized <>`

Thanks.
