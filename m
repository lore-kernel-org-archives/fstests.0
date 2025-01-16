Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37061A0731
	for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021365; cv=none; b=k8Xr0TckVuCwVPEWR8ZUE39Tvu9AJdosfAZy6AAKZUOwQxPurQGK3Ln/lG3tTtmgF97lwlHr5UgwLqlgrP/lNOx1AoBvewgGU6grvq+9ZRaB23JBIWI8stE7H7booOldW3TnMzVAbFsc7ae78OAsBRLhmcNnuBflGh2jvG68n4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021365; c=relaxed/simple;
	bh=renNwL4dhniz5s3y9f2DAAX4VntxyCogDTy/Tcf3Mic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBASkTLrOkYInUhe3FiHKVfyqCZbH0asau69dzq8J6pHcUL9hRra7dYB8pUlAEQFyhr/BBmUQXaNwrgffeLQNbpDnuUs4myai8g0jVreNr86V4QN3r8JTzRmYZe+Cp+w3cF455PQTcpGyyNwh4y0dSiQaT7+0Ot0Q4a8hN1HDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KvtYTd3e; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KvtYTd3e"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1737021361; x=1768557361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=renNwL4dhniz5s3y9f2DAAX4VntxyCogDTy/Tcf3Mic=;
  b=KvtYTd3ePAY/0glocZ4Pc2Onrc2uXI31q1kIJtHi4kLsneWFw/s2fin3
   aqb209KktWhXmp2m1oh+WNV6Hy4vMYEyTV/efOn4fNi1V+9X8z7YGFfAc
   YJ8a2TEAT34grR0BHW8IyeX2loGIbBI20fe0XlymiCbaJqkvayUtWR1KK
   5oueKt/hvLCGnOjXeGho67JtCizfaIX8YsIpfWyPlagZT0FN4K/1csXvB
   v/A1kkpSvrqawHyJz8a7vuyfNF1o0zeaQAbICEM6fPozwy72bYqG+7CtS
   YpNGCNpbGzPxgxExjjt1cXg9JlVuh6Gfk3OfnBz9SnYZOCZWD/3Wao1yv
   w==;
X-CSE-ConnectionGUID: l3txMpLDTg+D1Nm9ttU7WA==
X-CSE-MsgGUID: smFaELC3Tmy0Cur6dpqTbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="186990952"
X-IronPort-AV: E=Sophos;i="6.13,209,1732546800"; 
   d="scan'208";a="186990952"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 18:55:52 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 97211D6EA5
	for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 18:55:50 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6396BCFF87
	for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 18:55:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E52C1200649E7
	for <fstests@vger.kernel.org>; Thu, 16 Jan 2025 18:55:49 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 617931A0074;
	Thu, 16 Jan 2025 17:55:49 +0800 (CST)
Message-ID: <f514fa8b-0ed7-40c7-82ed-71fc54dd2dd6@fujitsu.com>
Date: Thu, 16 Jan 2025 17:55:49 +0800
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
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.006
X-TMASE-Result: 10--14.759000-10.000000
X-TMASE-MatchedRID: AyN7oo9wR5uPvrMjLFD6eHchRkqzj/bEC/ExpXrHizw0tugJQ9Wdw5Ky
	Pf1j7t43p905on3QBbh6zWO9halQsCYhSzEqEfvcbTdhrAcm88JZpTjhEveR0d9RlPzeVuQQ45e
	esIUwtzPOG+e9aAIpHutIG0QKUHPrHWE34M0GO85OKksNozKUfWMK3br1MaH4P4H+2nyK0FPgH0
	jYraCk7zBlvFlqyHBNgDdLwVatAdVEmmhct6O0TU7nLUqYrlslNmVjpriVEtnGZbX3v50Wr699b
	RNbA9SbYBA+EGmViA4kT9A++CZS0rhPu4tF1R7ButvHF25zoU92ZYwNBqM6Is3/nbjAiSxM0aUN
	gwfxxm6TOkeik9B9GoBStp5jwgJ5v1l2Uvx6idpGONWF/6P/Cg2V/fR8BQ7CKrauXd3MZDXIzfU
	dQL+UXQPOeRXlvAttHhcRLcTkb2jqI8WwF86aNi2tKLT8XYza
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2025/1/15 23:33, Zorro Lang 写道:
> On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
>> When build xfstests, a lot of "unused result" warning are reported:
>>
>>      [CC] write_log.lo
>> write_log.c: In function 'wlog_record_write':
>> write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>>    205 |             write(wfile->w_afd, wbuf, reclen);
>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>>    209 |             write(wfile->w_rfd, wbuf, reclen);
>>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>      [CC] random.lo
> 
> Hi,
> 
> I never hit this build warning:
> 
> # make
> ...
> Building lib
>      [LTDEP]
>      [CC] write_log.lo
>      [LD]
> Building ltp
>      [CC]    doio
>      [CC]    fsstress
> ...
> 
> Besides that ...

Could you share me the info of your build environment?  Such as OS, 
kernel, gcc version.  I'd like to find out what wrong with mine.


--
Thanks,
Ruan.

> 
>>
>> Mostly are calused by not using the return value of read()/write()/...
>> Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
>> won't cause other problem but make the log clean.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   include/builddefs.in | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/builddefs.in b/include/builddefs.in
>> index 7274cde8d..edf87ff00 100644
>> --- a/include/builddefs.in
>> +++ b/include/builddefs.in
>> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>>   NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>>   HAVE_FICLONE = @have_ficlone@
>>   
>> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
>> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
> 
> I'm not an expert of gcc. From the manual of gcc, it says:
> 
>         -Wno-unused-result
>             Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.
> 
> Looks like the "-Wno-unused-result" works for "a function marked with
> attribute warn_unused_result", e.g.
> 
>      int __attribute__((warn_unused_result)) foo(void)
> 
> I think fstests doesn't use that attribute.
> 
> Thanks,
> Zorro
> 
> 
>>   
>>   ifeq ($(PKG_PLATFORM),linux)
>>   PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
>> -- 
>> 2.43.0
>>
>>
> 
