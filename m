Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C41F708A
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737093331; cv=none; b=dsJ/OCN266XgSqEpgu4B3Y9cGAHf/AhHszQ9u5/sSOoCo8DczCOLteUVPb6HUTMFQ14vshnXq1+fW8XxyhfkZKTtcw0v/Cx1WdMgqDastvSy0SttQzCjpOLzJH6dIqog/ZXM/V0cDzTZhCI51H+xoli783Idf6YdaTUPM2rWqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737093331; c=relaxed/simple;
	bh=2AmX/RoqkW5c2hDcdXhSab+O4DfFeFrxmRheb3pswxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plu+oaFPtNZJJbb7b7ER0i8T12Y0FofSaYrxSznBBFMu7C7rN+RKv8HXrIGtQuudqoT1EDmgxD2a7vcTj2gpfufA9uHvJVwMFDmawIh5chhTGQyScKdRbedR1li2E0B3xbtRIlaAA2R+JswAT11TyiSA0J/P+tAS/IWOCGR3DuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WX7CuNss; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WX7CuNss"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737093330; x=1768629330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2AmX/RoqkW5c2hDcdXhSab+O4DfFeFrxmRheb3pswxI=;
  b=WX7CuNssYx1O1NOg1Sn6t+4pL9XaJ9eJlgJlN+lsRWoTRa1/8LC5e5jN
   yVPrbcNB7UIlopDq6Xw6afu/L5ylYNUYigDVevZIYPg6ACcKhdiowm3IC
   fpF/0IHo2TCbrUJn0OkMuwp9Gdxfl/8EjpacX/rMRjLpULb1CIXGQ7grD
   EoRifFFc9YnT60PJKqF/Ufw5fAg0zb1NcfktYi0K/AuGAchzm485+NKtU
   EXf4dQu3tCs06v4P1tr1ffLtRW9XPHw2QxyFFlqCm5bbhzTbxXL9PEapm
   JGmDU5FPNYm1VfirAjiDVisD11ILz3BklR+jvVeHwwZ6WdR3n5ejhQZvT
   g==;
X-CSE-ConnectionGUID: In9tnozaQ6+SAWnuB+d8Cw==
X-CSE-MsgGUID: yzUqwzbyR02dy0k7ChXZ6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="186870743"
X-IronPort-AV: E=Sophos;i="6.13,211,1732546800"; 
   d="scan'208";a="186870743"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 14:55:21 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 65EA8D6EA1
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 14:55:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 35054C8BFD
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 14:55:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5FC356B9BB
	for <fstests@vger.kernel.org>; Fri, 17 Jan 2025 14:55:15 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C50551A0073;
	Fri, 17 Jan 2025 13:55:14 +0800 (CST)
Message-ID: <b58e1846-1013-423c-bd64-0723b35c1659@fujitsu.com>
Date: Fri, 17 Jan 2025 13:55:14 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
 <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f514fa8b-0ed7-40c7-82ed-71fc54dd2dd6@fujitsu.com>
 <20250117040125.376lvwkd6ntvdc4o@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20250117040125.376lvwkd6ntvdc4o@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28928.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28928.005
X-TMASE-Result: 10--18.868000-10.000000
X-TMASE-MatchedRID: oL1vkY0RODaPvrMjLFD6eHchRkqzj/bEC/ExpXrHizw0tugJQ9Wdw5Ky
	Pf1j7t43p905on3QBbh6zWO9halQsCYhSzEqEfvcbTdhrAcm88JZpTjhEveR0d9RlPzeVuQQ45e
	esIUwtzPOG+e9aAIpHutIG0QKUHPrHWE34M0GO85OKksNozKUfWMK3br1MaH4P4H+2nyK0FNak3
	CQaL3CztGuyQl2cusOx1OrfZ+H8cGALyud/IM6VAIsE3tCKo2XmZiw53dqSN+3L2aPW6sT0pkPa
	0+0uDqjMGW8WWrIcE2AN0vBVq0B1USaaFy3o7RNTuctSpiuWyU2ZWOmuJUS2cZltfe/nRav77ay
	fVJ3v4aT4MVfZK1pgWB15W8F6q39exXX42Ne5dQEOhHzDsL05oep8IrGOvnNyBXJN3+n78jCdPA
	7VJefXefOVcxjDhcwAYt5KiTiutm/v0UhTKC9nMRB0bsfrpPIfiAqrjYtFiS7xj6FQx7lzpW7xb
	OvyrwakhukdONPtsPyscglPZaUKn7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2025/1/17 12:01, Zorro Lang 写道:
> On Thu, Jan 16, 2025 at 05:55:49PM +0800, Shiyang Ruan wrote:
>>
>>
>> 在 2025/1/15 23:33, Zorro Lang 写道:
>>> On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
>>>> When build xfstests, a lot of "unused result" warning are reported:
>>>>
>>>>       [CC] write_log.lo
>>>> write_log.c: In function 'wlog_record_write':
>>>> write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>>>>     205 |             write(wfile->w_afd, wbuf, reclen);
>>>>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>> write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>>>>     209 |             write(wfile->w_rfd, wbuf, reclen);
>>>>         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>       [CC] random.lo
>>>
>>> Hi,
>>>
>>> I never hit this build warning:
>>>
>>> # make
>>> ...
>>> Building lib
>>>       [LTDEP]
>>>       [CC] write_log.lo
>>>       [LD]
>>> Building ltp
>>>       [CC]    doio
>>>       [CC]    fsstress
>>> ...
>>>
>>> Besides that ...
>>
>> Could you share me the info of your build environment?  Such as OS, kernel,
>> gcc version.  I'd like to find out what wrong with mine.
> 
> Do you use gcc-15?

I'm using gcc v13, installed from Ubuntu 24.04's apt.

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-linux-gnu/13/lto-wrapper
OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
OFFLOAD_TARGET_DEFAULT=1 
 
  Target: x86_64-linux-gnu
Configured with: ...
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04)


--
Thanks,
Ruan.

> 
>>
>>
>> --
>> Thanks,
>> Ruan.
>>
>>>
>>>>
>>>> Mostly are calused by not using the return value of read()/write()/...
>>>> Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
>>>> won't cause other problem but make the log clean.
>>>>
>>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>>>> ---
>>>>    include/builddefs.in | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/builddefs.in b/include/builddefs.in
>>>> index 7274cde8d..edf87ff00 100644
>>>> --- a/include/builddefs.in
>>>> +++ b/include/builddefs.in
>>>> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>>>>    NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>>>>    HAVE_FICLONE = @have_ficlone@
>>>> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
>>>> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
>>>
>>> I'm not an expert of gcc. From the manual of gcc, it says:
>>>
>>>          -Wno-unused-result
>>>              Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.
>>>
>>> Looks like the "-Wno-unused-result" works for "a function marked with
>>> attribute warn_unused_result", e.g.
>>>
>>>       int __attribute__((warn_unused_result)) foo(void)
>>>
>>> I think fstests doesn't use that attribute.
>>>
>>> Thanks,
>>> Zorro
>>>
>>>
>>>>    ifeq ($(PKG_PLATFORM),linux)
>>>>    PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>
>>
> 
