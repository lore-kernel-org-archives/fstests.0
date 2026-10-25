Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792942111;
	b=ASdLYKKhjdtEY30mw2dtSLunOWHHMoQ5POrJecNEgDbRWpGRDm93BVNGhfQQM1vA3PUI
	 7tP1NeCt9bdwpUErZ5mHSGkEF2PByFYPQ6zNb3LqnyRJKr4gIsi5PMjJGlezkP6/MF66n
	 +/l2FITV32/cqnX41Ll+JzBwR8Tv8WW8miHaAbtQbFKUfi79J0JgEWuVChTr2ByHlSlbt
	 Bik8eLE0SX204C+iX6Um/vV6Hffdp3L0ODAOgxe9PeVrHq1mppn2il68NrWektAzQMw+F
	 y4uybyMaRUmVAlkywv5vOymXbDrUO/kR1eafPjsXHas0aVCoaTPr89qbKw0tsjMOQ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792942111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CaNBdB7iWC8I+pMSXF22JZ5nH4RtrrXSDHRDleoFFME=;
	b=Tu+j75TPbCGJeR9pC2b+zZoJrWpXPIKBEbaoTVXFBsRLZmKoUmlV+oCG27/m/2DsQ7gW
	 hhylsTv22vjqg0czdNFbsPK6+lluSQFLKFMP43BqbQuFmn27LNUdsNfed7DUudPOPM9ac
	 7S5dPAlwzi3yZ/DLF4fobWAnpCFVPJ/MlJUZMvwrR9WyJu+gtbGrWeGjuL107r+ey5yLo
	 Lkcgf7cvbR6fxuzp5dxrapXG4UWl7A842fPd3BHzHNQ6YQ2L9RhV4GbnTEvO10vJ8Nbes
	 JJx6qQ/TqY8bEKsFFmBa6/4RmQmmJY6a0FGguOqOkcTIwA7gJTpYJmR8fz8gaEDbHqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIR1MhZP;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A5606A31A
	for <fstests@vger.kernel.org>; Sun, 25 Oct 2026 15:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIR1MhZP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35829219da8so4087451eec.0
        for <fstests@vger.kernel.org>; Sun, 25 Oct 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792942110; x=1793546910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CaNBdB7iWC8I+pMSXF22JZ5nH4RtrrXSDHRDleoFFME=;
        b=gIR1MhZPQ83M1k2coX/tRLmtNnfRRNGI1m/H7PcPvGPUs/FfFQDSkZablT/V2PLAY5
         j36hDCKII4wKFMoIH+1KgF/7k71x8HYCvqg7nBc5RUFt+uod+j3QCB0RwNuzSC8cydij
         GLmPUMXR1dOwbrOOza6H5oS2rZ8wu0qTfTkFIMy0qarpYA4wTLQFlSxPOaf7Vg+Rhd89
         qt0KREV8x0hlOuWVN+y/0W7ucyPvR4B60Y2Ml6MWHhXwDpizi6R5ZD3ARIzvfSbIMiSe
         81EqiAXb9SV84FCncazEGEFagpPG5pabk5kfpnhTczODzRhsad6v40jtv0SfC9dJKhY6
         E6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792942110; x=1793546910;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CaNBdB7iWC8I+pMSXF22JZ5nH4RtrrXSDHRDleoFFME=;
        b=rr1E3j74bfG8vRskgULvh9en1XJT7EYSSob0pxN0RyQUI1agXNMb4tS+R7ggJCjhcH
         A8mQMHC4ojiIYnxs0kk+tLr+UpHVtuH8ej9BjOZu3UlytXwLfCxJFpEaxkEq7/Yir++m
         RAFzuwoBlIvbR43V9aHhJDXB98+1aan44X82FCc9dqwTay70XREM85y5ZbaQ9WHIjGAW
         6qx+zEwb3taU2f1rmZpgzVoLzI51HgKlnnEjApsrMheNhIjE0me6Iu40jCDyLJG5M0MS
         5vMuuTQHkXvGgg5OclXrVO1u1Bhq/7LQHJ9EEDyIc5RQ/Yix9IvDL5p/s+OYai2qtr5q
         VtXA==
X-Forwarded-Encrypted: i=1; AKwUvBzkHhumSesifJ2AihV2sQ6jbM3qpet10EbW/f6S8SzeQ5tGAliTKvVVttdkeb0yX/qDhSeVM0xc@vger.kernel.org
X-Gm-Message-State: AFq9FYKonnwOxHcvLnGSUtvAtFS7O9EUjhDEg0zLBAGtbSmFZM79O2Mj
	b/iGxxmp30bcTq8JUVJSSDkjdBfUZUH8/Rtx23KKbAkQxlvcOqRZ20/5
X-Gm-Gg: AYBFou1+79hbcJaqisQjjEJrLDk1SAOLI6D7ECSPnTYi5fFlxroV8FJ4ZDB5JlJ4RLJ
	N2wTTQtNTGounI8g48GyefOjLhc4B3qEkRftVyVMtIjdTSjdK+bcQxG4UINwHrHGxlRw/vBxMX1
	RAZlLJuucv2et+HWIrv0As4fnrznkxiRz75Uud+gj3rvYjg6AqzaCF5uqZreJuLVszIpuW7L+Th
	/Ap95R0zK6fBQ4lwPcgy0wrAZ5q2aQvNL2dEohVhSjrVcfy1UuqNut7LcDxj4/SwxKbkzeJdfkS
	zJXWb2LzCuQI9zH6+X9p9vjo6pqqvU6391medp20ScOqKI1Vs5pJUXHKLwJJTiLnQY4zZjbFqNB
	0yckmE5AwfUPGDufRJ3qBVt+HujSQkzQ7hFBEbb/NLCYrTlNk7l4/5qz6fcOxw3TZTj0E2ein3Y
	m2w+dlRF2rCBSOmdLiB+sDQU8AcqwzgDugJLdde2KH4bhzNQ7rcw4kVUrThWI5pXA0M38ZdoRYW
	h5MjHoaCKahHsgp5OxOVKItP3bGOCT7NXkfe0O6qWlaryOroh5l66Mn5Z04b6zCtqpKWkCLlI6X
	dldNgdcn5U5xGiEU69xGo/lFoYh2EtDku6cZ1xi6zAfHIcEp8E/sp+p2418=
X-Received: by 2002:a05:701b:4213:10b0:19e:3464:ce40 with SMTP id a92af1059eb24-19e3464ceffmr2522187c88.1.1792942109756;
        Sun, 25 Oct 2026 08:28:29 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:97af:71ef:5d3:5a66:5bd7? ([2406:7400:56:97af:71ef:5d3:5a66:5bd7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm15314075c88.8.2026.10.25.08.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 08:28:29 -0700 (PDT)
Message-ID: <17693fe3-9b88-4efc-a8ad-3804fa675a7e@gmail.com>
Date: Sun, 25 Oct 2026 20:58:25 +0530
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fstests: generic: add a test case to check fsverity
 reads
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
Cc: ebiggers@kernel.org
References: <20261017090341.72079-1-wqu@suse.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20261017090341.72079-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17-10-2026 14:33, Qu Wenruo wrote:
> There is a bug report that with the recently enabled large folios
> support, fsverity enabled files on btrfs can trigger reproducible
> warnings about file corruption, but in the end no error is returned to
> user space.
> 
> It turns out to be a bug in the btrfs fsverity integration, where blocks
> not included in the read range are passed to be verified.
> 
> This is a long-standing bug where btrfs fsverity always assumed that one
> folio contains exactly one fs block, ignoring the fact that btrfs had
> block size < page size support before fsverity support was added.
> 
> Add a new regression test case for it. The workload is pretty simple:
> 
> - Create a 32M file
> 
> - Punch a 64K hole for every 128K
>   This will limit the read bio size to 64K, which is smaller than
>   a lot of large folios, and thus can trigger the btrfs bug.
> 
> - Enable fsverity digest and drop page cache
> 
> - Read that file and verify its content
> 
> - Verify there is no "FILE CORRUPTED!" warning
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog
> v4:
> - Also output the checksum for the file for content verification
> 
> - Update the comment to show the requirement more clearly
>   It requires the folio size larger than the fs block size.
> 
>   This means either a system with larger page size (e.g. 64K page sized
>   arm64 with 4K block size), or large folio support (which requires
>   transparent huge page).
> 
> - Minor comment updates
>   * Concentrate the mention of large folio to the triggering part
>   * Explain why fserror is not utilized for error detection
For this version too,

Reviewed-by: Dhruva Gole <goledhruva@gmail.com>
Tested-by: Dhruva Gole <goledhruva@gmail.com>
