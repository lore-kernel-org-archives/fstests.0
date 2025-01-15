Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03E246A26
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932539; cv=none; b=BsZSln9lm5IbwuDWZAkb+V46TRNINkGm+lysjUPiCyiKXb0I9GpgHpmBEwhpW5z2m/vbbZFjZrQI4prYIlS24VN5JCSdGvlho2DMvjWLaiZUVLAkTqq8ig87P1tESDxGcbiykRjeHvIsfuhe6Jpe0pEGUb1oIEHvVtuurBD2CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932539; c=relaxed/simple;
	bh=dZawQwJMB5e71NjFrfTWL4uE38wkpDoIrabP/uuL9ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfqo6NyPBqtIO+9X7J++DG5IiY8EraRMQ2kNSddzQb8cKc5jP/cpRUV6DgWItS0YKKUmgvqf1niB8BfDnSpiIhsts++VV/SWn7rKM2fHIpaipSIj9z4zjqzj+lSMR4zk3FI0wccJExu1aTSf0rA94vIiFpL1nbr843bd9jeVHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OVy7OTdk; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OVy7OTdk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1736932537; x=1768468537;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dZawQwJMB5e71NjFrfTWL4uE38wkpDoIrabP/uuL9ss=;
  b=OVy7OTdk62tHU/TDIEaXFAqCsLQEldy/0Go3m5emzqHPm2oFJOCCuPlp
   o++7Hun12GfCariBB2MLxXOeuEhRa/MuKGuFWBtwMp7dLW2P+nUoxK308
   7VKTpwXZRNU6PeJZx9rZbRCm7+riKJk9zUA+D6BTPPwPhHRBoBCXS544Y
   wgCkuiO0KvUxw2yPomgLImejdV9bk4BlxoHmfyxz03nQzoKl8TE7EuxTs
   lbwNrAQCHfJtrvfncY6TdaIEC4O+9XpR9m+SdCvfyx0au/dQ0UkJt1BYh
   qxzbX3w+Wn3A/Wjqgs005amcmuLVWhGnaqfKu43kpvzv/J2n9mJ7N0wBC
   g==;
X-CSE-ConnectionGUID: 8ajKS7TcSYWfo1TEZzSfUw==
X-CSE-MsgGUID: zJaA9gLgSTmvnBC+6xyW7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="174613900"
X-IronPort-AV: E=Sophos;i="6.12,316,1728918000"; 
   d="scan'208";a="174613900"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 18:15:35 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id BFD9FC2266
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 18:15:33 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 94D6CBDC87
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 18:15:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 263296B98A
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 18:15:33 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B55561A000B;
	Wed, 15 Jan 2025 17:15:32 +0800 (CST)
Message-ID: <e4aa8e6f-71e0-4e62-9353-29a50845e5bb@fujitsu.com>
Date: Wed, 15 Jan 2025 17:15:32 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
To: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28924.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28924.006
X-TMASE-Result: 10--6.537600-10.000000
X-TMASE-MatchedRID: AvuQOGDihJqPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxGQgIVrmBL5P58
	sN9xQ+ZUTWG6JBHI8bbeqzz6tT6qzUpOsvsL8hZ08Jb881FGn9lMkOX0Uoduub9dKxA1a0J4sHj
	E9OXcNYci+t+0AiFaYnPdLa5gR9leZft32HYSv9saiJGVIKHj9Ui8rgutezVpxiYJGz7qtIOjxY
	yRBa/qJaEwgORH8p/AtwKUvHHyXGXdB/CxWTRRu+rAZ8KTspSzTFwbhMYjAGD4ff48USy1RZJmO
	ClensIvJBTl1FFB0AOeBlFQ35CJvo/CutQXDSiyn2cX/RRsC12XEB4kgsVvjCUQVBOsaxDkO4P+
	68fHBXmH0xJi24ejBBoz2YHPaOhG8ALsba0G0iR+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

ping~

在 2025/1/6 17:59, Shiyang Ruan 写道:
> When build xfstests, a lot of "unused result" warning are reported:
> 
>      [CC] write_log.lo
> write_log.c: In function 'wlog_record_write':
> write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>    205 |             write(wfile->w_afd, wbuf, reclen);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>    209 |             write(wfile->w_rfd, wbuf, reclen);
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      [CC] random.lo
> 
> Mostly are calused by not using the return value of read()/write()/...
> Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
> won't cause other problem but make the log clean.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>   include/builddefs.in | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 7274cde8d..edf87ff00 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>   NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>   HAVE_FICLONE = @have_ficlone@
>   
> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result
>   
>   ifeq ($(PKG_PLATFORM),linux)
>   PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
