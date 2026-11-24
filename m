Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531922;
	b=XmiNLqPioqwOlKfU0gFad20taR4m5qve9M4sD9XA8isu+MOqLANqFPqulWyYoVGalMy2
	 7+27zxkVI7N6+JqQqDHvg3/H1kDBilFWEBXoSNNhXzMZ/QHhmdjf65+n3WW7VarYjw6o5
	 FB9CZhvZLTS3JfM/vFBjWfcDShyZ1iTR1roW5RPfL2z76uDghdJz4HzHwrGrNGipSYR6D
	 dpNSaVKrkKgsq0NcXvaM/IkeAUUSL3bx48oNFO/TykHZw+Wk+XQFGkmvRfM5o8M/IFIBI
	 DcIwQCS3JKqIHjowK0pwYq8ogKyFzvZPqnOiv3w6qabyVg5zvX+ooHdJelcommM32ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531922;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KghyNzhT8zjq9GIvhhwd6lq0x4fbIDgavYP9599Fn7g=;
	b=No4WOitmenyU9RBIW9286oJDlrBAC3MJlfBQNV3EUf3PFiufaPW3ne/pkzv4gbfgMkau
	 OSrsg7D5AC4MMPBHkANFWy6mw2TUxxCn6RFfbQWGLnNXuKf7YRkAGJYqZysHKbDIJCCBS
	 ZD8EkUHadyC02L1JwFI8wmX+BlYggTjY0a+W9yewjctOL8HS4vTY04fel170k2AyxBb0s
	 5KpOkLIyMCH9QPQgMDYxBDfrkZncOiBy5zTVP+NIuv1myahFa8n4WWzzjEcRgiDivvnXg
	 sWNY+zREztCjsYJWjr6mTA1L5ORd30aYvVv2jyLNmKszSfmGrheKNUWY+lVxhQ3u71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQ5hSsEH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bxeqi5cB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B1606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 14:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A0B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQ5hSsEH;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bxeqi5cB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795531921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KghyNzhT8zjq9GIvhhwd6lq0x4fbIDgavYP9599Fn7g=;
	b=eQ5hSsEHUOyt+Cfuy/0lqrEjRDSaCrF5OW5IUhU/8VdCS+5ls4tWoAtrCg5V6hlwYOSt+1
	goD/98qMKD7beXoDsrhIFYOVcG6PeuC4t3acbUEXeHfOiAhGGV9cCq8Loxi1cPed3L+nEO
	FoERGdvq86FDnRd9TNbxb9zO5OT3gu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-u8Z357IFNJab_BXxHLVDDQ-1; Tue, 24 Nov 2026 14:51:59 +0000
X-MC-Unique: u8Z357IFNJab_BXxHLVDDQ-1
X-Mimecast-MFC-AGG-ID: u8Z357IFNJab_BXxHLVDDQ_1795531918
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso32458475e9.1
        for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795531918; x=1796136718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KghyNzhT8zjq9GIvhhwd6lq0x4fbIDgavYP9599Fn7g=;
        b=Bxeqi5cBBCVgOX/cKyJOiXQ7FtRO//frqScU6S9M5uaWCflgKWk4w0AAsq8VQACRsp
         A2/jRINCv5nlfrqSaOjh/30AbUQArOuRKq6MpiMrnZQBc2WBUhMssKPj4TXG2Vw/6v13
         iTwb50PCeeCWVfNbbnIvzfENDqJVQl0CtfmASt/YGxbPleXWESDIiAp5mCZgFvFOi2E5
         VM+VsBJmbFCFNduolr0F4ikqI8aYvPaPKmDLj34aBfq8kPtAtQ4PmRXeiSJUtkF/VDAt
         FSGYwtWyaXeZ/bATjzPpiQay93TaqTiz3vJLTmvU6EtNd94IlRyk6JGSN/iGFH2lcpVS
         1rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531918; x=1796136718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KghyNzhT8zjq9GIvhhwd6lq0x4fbIDgavYP9599Fn7g=;
        b=hQzN69M3vfmjSEXlPX2ncXZqfTQx8KhYHlOkns+xpT8eszq2vn0oTRVrh2XlnPech1
         dZZqNl3EVIsghW7HUvgUjxVeUuNfrNkiz/c8h18XdpLTS6mXJufuEcdLzodfbYOkqgkS
         kEKCVwVPjEgK3wIK1oqyzl/WXVEygZUIYZOmi/t4lSMoW+85i5j71V7CUJgBl3LDP68t
         t8o6Yy4zYB+K+VYkWZxR0h/RmMikDz1HWlL/Qw0EMT+RLbFunURAUgKo15HWBZ6ASM8y
         bS6d2v6N8K+TbAedxXj1XxB/qx6YJ+YzfIcTwvu6/R8wF29mCAU6yfyoNcuFYrhbuEC5
         12WA==
X-Forwarded-Encrypted: i=1; AL+hErHFoa58YvfkF6itJepU/Iua1/iYUqz8IEsFZ2VApkgXqXNmED72cpocLgqrtZNojaEHQZpGzH/B@vger.kernel.org
X-Gm-Message-State: APuU4Z/Kkivnm/whQhWmcy4kVFZE6l4PD1OIk+WLN/iN33gt5sVnnVa1
	lECl0sMlTDzj0XyhhIWYZFcBcmGo7auOePOFTmlFKWiBpd0+c0Q9TziPN1JFw8htPRxlgEjCwIj
	JTvX02nDlEQI6Ic2GlG7emns55juhM9Uhd4atW19qJm21zK+/DPqmoZ6alwjB3Dbpxg==
X-Gm-Gg: AZFdTZew4X1MiUXnG952YOqF7+TKZNwSHsvVkxZZbva1MANdEfNlbEuFIL387zZ4c1C
	UaMVSQc082vsUn1bZatjtewpFPQNafqSMycagBdZT4sorukgxTB8Z4Uwiq3Ow+HB3Bvf4N6UPSG
	XfyROMTM5i45lMOigkJD3YzAXO+b61LOmq1URtf9Y9sqTkfCpgeRLithXQqjcO0fK9rs/esdOlh
	IlnCyoOciD/py9MuVd1jwBliA4x5EUGTnagRR/+o4s7vqcQnDaw2r3iaQqeCa6AZQOJyDDDCYTb
	0euaA/V9/uqfipcT0bLw6ExDsuKXiWefEygOn+70E8vhPD5wE8pla2Z0hDjMuiwHShyihS52PYB
	8QMpTKM8yBg2fnAYFd7PTmqQhcjlJYxLBXiINC8o3UhXLBm7ERS/lkPtjREAXkVeDcvYsqlp6ml
	d1yK7MONU=
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb8892cb02mr298484355e9.21.1795531917981;
        Tue, 24 Nov 2026 06:51:57 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb8892cb02mr298483965e9.21.1795531917409;
        Tue, 24 Nov 2026 06:51:57 -0800 (PST)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb4341sm28772927f8f.4.2026.11.24.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:51:57 -0800 (PST)
Date: Tue, 24 Nov 2026 15:51:56 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: cem@kernel.org, fstests@vger.kernel.org, jencce2002@qq.com
Subject: Re: [PATCH v2] add tmt as a new output format
Message-ID: <awWiVSZTul_KdB3H@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261119123910.294544-1-cem@kernel.org>
 <awDMOOZxtQW8A4_v@zlang-mailbox>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awDMOOZxtQW8A4_v@zlang-mailbox>

On 2026-11-21 07:19:26, Zorro Lang wrote:
> On Thu, Nov 19, 2026 at 01:38:55PM +0100, cem@kernel.org wrote:
> > From: Carlos Maiolino <cmaiolino@redhat.com>
> > 
> > I've been trying to expand my testing matrix leveraging the testing-farm
> > cloud (https://testing-farm.io/), which is a public testing cloud available
> > for opensource testing.
> > 
> > Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
> > tests within the provisioned VMs.
> > tmt however expects each individual test to be, well, an individual
> > test so by default it would put a whole xfstests run as a single test
> > case with a looooong report.
> > However we can use a tmt-report-result tool to report each test ran
> > individually as a sub-test, so the report looks a bit more granular,
> > easy to read and prevent my eyes from bleeding while looking at its
> > testing reports.
> > 
> > I know tmt can also be used to orchestrate tests on a local machine.
> > Although I have no use for that, it might be useful for someone else,
> > reason why at the end of the run it will also print out the tmt report
> > file location. This also makes the output consistent to what xunit
> > format does.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
> > V2:
> > 	- Add Murphy's suggestion to the log output if it fails
> > 	  to add a test result to the final report
> 
> Hi Carlos,
> 
> Sorry for the late reply. I wanted to wait and see what others thought about
> this first, though it seems there hasn't been much interest or feedback on
> it so far :-D
> 
> ...
> 
> More recently before I was laid off from Red Hat, I had been considering adding
> a generic hook mechanism to fstests instead, if a user sets an environment
> variable (e.g., REPORT_TESTCASE_HOOK="/path/to/my-script.sh"), fstests would
> invoke that script at the end of each testcase with arguments like (sect_name,
> test_seq, test_status, test_time, report_dir). That way, any CI system or test
> harness could simply provide its own lightweight hook.sh to reuse this reporting
> interface, without having to hardcode vendor or framework-specific tools into
> common/report. Also I thought about adding a streaming format like JSON Lines,
> where each completed test appends a self-contained, valid JSON record on the fly,
> ensuring that whatever has been flushed to disk remains intact and parseable even
> if the system crashes midway through a run.

Regarding the hooks, I continue to pull this patch by Dave [1]
into my test machines; it adds generic per-test hooks. I use it
mostly to run trace-cmd but this could probably be useful for some
kind of additional processing. I find it pretty useful.

The original posting didn't get merged, but I can resend it if other are
interested.

1: https://lore.kernel.org/all/20210722064725.3077558-1-david@fromorbit.com/

-- 
- Andrey

