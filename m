Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8B18C32C
	for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522575; cv=none; b=SqB6DcxxgGxvh9w081Cb2nzckl7gmK7MaoWtBO1asBkRIQjKaPq7jCwym+5v8HNdLe3YzeII+Z8dBPEYavXcrDm1WEDfFjeuGLP8Gp/jeFaq6aXmbKNYCrBzWmx8HCAtyq/ueRecTVfNge2ZBtsGehR2gxjsMhEy+tOnxtBRs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522575; c=relaxed/simple;
	bh=jCv6z9QG/W4clHhOWSXZndftQWDJ7JQezewq94GIMtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=senNxXPGp8gAXbXB0GlYDb+F4YUATJczXs+ZFQyBv0Hzes+Xl2G+lurbqMCxN0dIw/n86pNPzS48wI/6qkwOpwKMySBBiPzmlmQzzTYLDlkwZCe2WeV3Df6QONRHNkqfUFdqG203plgRJyT2+2lbZY5awIfbth3UW5LJc13tZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj4Oz0Ha; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj4Oz0Ha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740522573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0LnSOUeXdwrHsKbdv5Rp9HsxXDNeKslBy2sYrbvkro=;
	b=bj4Oz0HaTn4O6qTyZUQ440X+YMBH7gcUlUE/T/RDjK7bHZJ6c8lI5MDhy7zph4C7GEaKTQ
	HspEk2LC7xAJ4jNbDyzBrbFmcH6pPmNyETMz2SZTkQxAiv9l+CDNiwtd7LK2lWwRl+jlLb
	/a5oIOZWcWNazOKbYFK+5Ce4DnuLJbs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-yKP7EGYjPPSK486rvAbCTw-1; Tue, 25 Feb 2025 17:29:31 -0500
X-MC-Unique: yKP7EGYjPPSK486rvAbCTw-1
X-Mimecast-MFC-AGG-ID: yKP7EGYjPPSK486rvAbCTw_1740522571
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so118907745ab.0
        for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 14:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522571; x=1741127371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0LnSOUeXdwrHsKbdv5Rp9HsxXDNeKslBy2sYrbvkro=;
        b=t4c12dyzbBW5JMgbRxtp4S7AQyn27Trpl3J/XOs0VK0BBE/tURAmDxw6QJgkrktSvt
         SsUSmmxr8P/zJabXMXFRcEU0aw3KbqZ+NdaJdwOEscm05/NrxChWDiDm59eD8i29qEnw
         GGVnr5Mp6ad3ckh6kZi1u30dYGv+4dirjpa5KXulzkZ5WDeSUpqfimotMAvHSaSh2IID
         xhj/FGZFjH57ZKijBe4ClSQVn0iO4kQ7go72HMhxuGMRaq4NfuPHJCwqNdcTUiNt0VFI
         BlntL7KbmBFMnSq4o+Hr+w72LWNnTGiTmsRPWSYdARb6fkujuC1L+ALv+EQX2VhqiSPs
         QrLA==
X-Gm-Message-State: AOJu0YzFA3FHLazGG09TdHoclELOT1iHsazAw0S6/Z7j9iChQJrGfMCx
	FhmOCu+D5E3h5LUNvUsycchhdE6u/Kc37YaYMSfo/EdNNyHJYCspb9U33NMDL+d6NUewkHBs+3i
	WA3Pc7300sJ5MPt1WiAdUaA3DI2+ALwS8ICLyc0q12q/tTWKhKmccS/g=
X-Gm-Gg: ASbGncvGmtOoFGxyMdZyLsMxEVaIwzg2jisUqN/G243JLzQE17/TzlYYTs13pBp9gIu
	DDQeY1qdxrO2/YjqGKGolyjJsJsncPkDxR8S2pDTHvjpDR2DXqimLnjx6illpoEhdKLYvBvTnL4
	udT4DyrHY1c1sUI4ex+YkD0VMRv3bnVWXmc4p1mo0WzAbxNR3dmeiVzxJRrfLLrghUgZr0QX5b/
	pZs4TaS+Z+2KA105aFA7cGSOg+l4Q3DpQvK3FNWuY2DZP1r4RtfR1ui3jDmJ+VrQqSoRuc7jmqt
	dRn64VzIgWkor0xLswC2y2xvj6GKzMen1WfmQEUe0/jH/sLcjPvopA==
X-Received: by 2002:a05:6e02:1c89:b0:3d3:d17b:2d99 with SMTP id e9e14a558f8ab-3d3d17b2efcmr18227515ab.4.1740522570866;
        Tue, 25 Feb 2025 14:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaRqpOKOAox9zu23GicK40LBWc0vdtZwsnZ3uqSqd/gRpje2z/sV1N8La1gfIfmasM97KO+A==
X-Received: by 2002:a05:6e02:1c89:b0:3d3:d17b:2d99 with SMTP id e9e14a558f8ab-3d3d17b2efcmr18227415ab.4.1740522570597;
        Tue, 25 Feb 2025 14:29:30 -0800 (PST)
Received: from [10.0.1.24] (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04752e026sm590748173.107.2025.02.25.14.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 14:29:30 -0800 (PST)
Message-ID: <58b204a2-4cf8-4110-8ac0-4543e1c4798d@redhat.com>
Date: Tue, 25 Feb 2025 16:29:29 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>,
 "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>
 <20250221164751.GY21799@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250221164751.GY21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 8:47 AM, Darrick J. Wong wrote:
> On Fri, Feb 21, 2025 at 10:44:09AM +0530, Nirjhar Roy (IBM) wrote:
>> On Thu, 2025-02-13 at 12:06 -0600, Eric Sandeen wrote:
>>> A bug was recently fixed in exfat where attempting to do a zero-byte
>>> write would yield -EFAULT; test for that here.
>>>
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>>
>>> diff --git a/tests/generic/761 b/tests/generic/761
>>> new file mode 100755
>>> index 00000000..e933eb83
>>> --- /dev/null
>>> +++ b/tests/generic/761
>>> @@ -0,0 +1,28 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
>>> +#
>>> +# FS QA Test 761
>>> +#
>>> +# test zero-byte writes
>>> +#
>>> +# exfat had a regression where a zero-byte write to a file would
>>> +# yield -EfAULT. Should work on all filesystems - write should
>>> +# succeed and the zero-byte file should be created.
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest auto quick
>>> +
>>> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
>>> +	"exfat: short-circuit zero-byte writes in
>>> exfat_file_write_iter"
>>> +
>>> +# Modify as appropriate.
>>> +_require_test
>>> +
>>> +rm -f $TEST_DIR/testfile.$seq
>>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
>>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
>> Minor: Maybe just remove the test file that is created above (since we
>> are using the TEST_DIR)and not leave any test artifacts? Or, maybe use
>> the scratch device? 
> 
> Agreed, the _cleanup should remove the testfile.

ok. I thought we left stuff lying around to age test, but I'll do whatever
folks like to get this one-liner test merged :) 

-Eric

