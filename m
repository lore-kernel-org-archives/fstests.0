Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB33932F4
	for <fstests@vger.kernel.org>; Mon,  4 May 2026 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936609; cv=none; b=H2v+uTebNhGk4v2OgL2iYFFObGsOhD0FcZiojfL1NS7uDsE+YNv9ATzSC0GtHRgFroPhHjGF1mjOR3WZ30ZxON/g02hHd3Jq3LGVDrJZ2S8tH/THlNFtPn2wmjzkb8u282XfmR26HIw3WOH9Rspk9gPh2hHNMUtvs3aB/3ETldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936609; c=relaxed/simple;
	bh=GT+NVb9IzNRl7jv5sfO58xbxSyRh1YQjk8rTr0vA12I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UFuhr6AsGJmO+4pUxWo2X3dEIm76b7iDBpOw27kTWhMRf92dImqe5lkdvd+9G/SF9teOaEGMnxyTc6wKkv9ELqpFZ04pDbFyYyYrlTikWeyTvkrsRtUyDLZ/4ePX5ODiJRmzOX7ArhYANhA5kBJbUgClLIGKIOyXPNKTgHSNPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO/KQ5Hv; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO/KQ5Hv"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8025f1c227so1245180a12.2
        for <fstests@vger.kernel.org>; Mon, 04 May 2026 16:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777936607; x=1778541407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVVCTflPQBR/6MOOzvGW4z3v1drFnoSJzIwzf+PfZh8=;
        b=FO/KQ5HvEMiNvaU9BmNQJtLmKuxftS+qvgDVEPWn8KK4i3C7nuW8MLCCye8X2XZcdV
         2fyCPYksM/Qwdrb3Z3kcIDGASC1T/BixaGkn1kZcXKBLsfGK3gYi5MadNXqGgcaXp6FN
         t2w3IQvom1qRbJU1HoTB2o3AG/3ZZNTMoL4/ifUSbL7Fw/yTbqwKOvgEWMHyuV+uAjjQ
         px4uFwna6PaEkBnOXB+t9ZATJNjCT/z5GWj3BgtVgQGjvrAuZK4KakLkkJPAkQbkoc17
         j+HB6Zu6Y255PXSkwZ7XlSmx9XE1CQiTeelDwg9zDsTtv1FRUOsncxoW9veWFqjVcr2g
         msdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777936607; x=1778541407;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVVCTflPQBR/6MOOzvGW4z3v1drFnoSJzIwzf+PfZh8=;
        b=nLS2+Nr7qpY5v1TtXLg6wdKdvDtHvOwNTnbHVkLzBWp+rlPEXGmO3nHdlowaNOlJCI
         ENbJIxsVMXlHj6cmaOTUQ+JcFoVJ9fv9B2d5ms5dVyY7b78hjZyVrXT/P7xHY3F8GYDO
         Z7wzga0P/528e46Ckfviq1DuXV5MtnIV411sZj6RIu+MgNGVfLi0vJ6x8wnHqszLxyKf
         KMURIRTcc1HSFAsC27m3QKJ4VCANiKmnZBP0Ar6KgUT3km6lZJy0LO7+PA38D31wdFv4
         L1upzh8kfgy6stSvwH+eghpp/yPUiD7b5tLHu0Yp7VoxHxmXEeW7FvusmViYXUMofYF0
         XoHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/T59jHXxJSJyXNWKs9UofnUQAGTRODUs8sLPBVDSJnzlDRimbdoAYrc7PQZTikIl27hy0Iwuq0@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMK8jYMPodbhALhh8nicQ6Bfrzr8wg52vdEmpXz5mZz1Jo4CD
	pHfB00Ot7zu7fjhGH/dGeyrkgC5Uza6mc7pVbnOxYzZqNGNtTTh23Vro
X-Gm-Gg: AeBDievzC94efFh3CCD39yXcP1BLb4rrUVVPBDCUBi2R84gIWXMEH3tNatUGeqPLbe2
	xi9EhXbMbi/J9UgYxtMDtPgVxFpiSKN/Zpt2oyMFHSKVa4qKl66eZgpWwBXEpqvwlGFNTdQhsdO
	fxqmdDOCgUq9e8EDsAW6ytB90kqmQohIQu3Nk8xaSSDP85W9cvuwU4vDr2evo0uywy3LeH01gTM
	7VdcU2frv++Egge7CRTNpT2CvgSFJPKtpOSVOxYHOC/s6XiKKC9VmbNB3RrC67qJWp9PAU40dRv
	ptumzBudU+ihmeV9Q2Y9cWuUbDRTFDZTbV/fRwMS4jdoeCiZd5HPtUyR+aTOC+28xZPUBPOV3Zo
	KQMwHaKSHouA+UclkKEOpnsyffm3U6UqazyJhjQ8m0LzKq2Z2PBWhiagYT2Y7CtEOPCpmi6qvbk
	4ET8OdesIal62V+kJhAXYRgixeOM6GZJP9gqlcCFU=
X-Received: by 2002:a05:6a20:7350:b0:39f:a42:9247 with SMTP id adf61e73a8af0-3a7f1c7bdb1mr12722832637.37.1777936606990;
        Mon, 04 May 2026 16:16:46 -0700 (PDT)
Received: from [192.168.50.119] ([116.87.14.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839460a0423sm209670b3a.33.2026.05.04.16.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 16:16:46 -0700 (PDT)
Message-ID: <3cc304b6-0069-4cb8-b3c2-a15d0365cde3@gmail.com>
Date: Tue, 5 May 2026 07:16:43 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] common/dmlogwrites: add _require_log_writes_sized
 helper
From: Anand Jain <anajain.sg@gmail.com>
To: Disha Goel <disgoel@linux.ibm.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, fdmanana@kernel.org,
 quwenruo.btrfs@gmx.com, zlang@kernel.org
References: <20260427122551.71696-1-disgoel@linux.ibm.com>
 <7a5a4c7f-2c1f-4dc8-b2ef-b052b62798dc@gmail.com>
Content-Language: en-US
In-Reply-To: <7a5a4c7f-2c1f-4dc8-b2ef-b052b62798dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 05:53, Anand Jain wrote:
> 
> looks good.
> 
> Reviewed-by: Anand Jain <asj@kernel.org>
> 
> Thanks
> 

sorry, not yet; I'm canceling the RVB.
Details below.


> v2:
> - Renamed function from _require_logwrites_size to
_require_log_writes_sized
> - Added documentation comment clarifying the parameter is in KB
> - Made function call _require_log_writes() internally to avoid redundant
>   calls in test code


 This change log should be below the Signed-off-by "---"


> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Anand Jain <anajain.sg@gmail.com>
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---

... v2 changes  here...


>  common/dmlogwrites | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index a27e1966..0925b333 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -14,6 +14,21 @@ _require_log_writes()
>  	_require_test_program "log-writes/replay-log"
>  }
>
> +# Require a log writes device of a minimum size
> +# $1: minimum size in KB
> +_require_log_writes_sized()
> +{
> +        local size=$1
> +
> +        [ $# -eq 1 ] || _fail "_require_log_writes_sized: expected
size param"
> +
> +        _require_log_writes
> +
> +        local devsize=$(_get_device_size $LOGWRITES_DEV)

Please keep all declarations at the beginning of the function.

> +        [ $devsize -lt $1 ] && \

use $size instead of $1 and

$devsize and $size units are different, 512 sectors vs KiB


> +                _notrun "LOGWRITES_DEV too small, ${devsize}KB <
${size}KB"
> +}
> +

$devsize is not in KB and $size is in KiB



