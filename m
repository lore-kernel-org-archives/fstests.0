Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2F1FFC59
	for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479847; cv=none; b=grPqq9yTHIdnmNIgsXQiczQPbcASh3xmxKUya5MZje2Wggdb5yrnTb8lhenBEStixFWR9PiItNnF/Veytr/nWab1MOWYYS84Pqra98R38ueb/g9Z8/wR9dmDAxPuo/ylHOPynCZL85PSKeVSyH8qwrpwjDiqxB0dlGi2fcjmqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479847; c=relaxed/simple;
	bh=9EaGDRxDgdHkB68AiPqOZg8AaLE07Pw8+S9B+CHtr3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKx2ZQPixNOt3OmCHy1Ihb55aoU6WIPIb5MrJ9xzLw85IXuRiDZXYDkxHQvch2SUcQUddgVHaHleMN/bendjlxj4s6B1U/T5o06XJfi8UEZbR2NXJzqq+vfALrihAfaVL9z7CXtnWddtYz7t5mlvErcizpHjsEcaphrR/C1sHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNmVs/Az; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNmVs/Az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X03XE6KPkUO14E6f/81I6hW5Szx+mA6rao9rMbGMQuk=;
	b=DNmVs/AzkF2I4ens/EPIGEKzWqPh/ZnqbEviZWGdTsJJqPkL3OW75hOPdHeP02aJCY6BvY
	GiEnnfssE/7pgXt7g/0XlKyvrqgqXL1CyqwC+1WGNAMNJbO5E6znpYmX+lZxLz/8s2of0T
	yLT67yulILmx0Xad5BXAY++WeX3B7uI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-uO3C0HWPMCqLSYcFGMV_Cg-1; Thu, 13 Feb 2025 15:50:43 -0500
X-MC-Unique: uO3C0HWPMCqLSYcFGMV_Cg-1
X-Mimecast-MFC-AGG-ID: uO3C0HWPMCqLSYcFGMV_Cg
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-855635c9d0eso94517939f.0
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 12:50:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479842; x=1740084642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X03XE6KPkUO14E6f/81I6hW5Szx+mA6rao9rMbGMQuk=;
        b=bWphtMZzJsiWBNW60+wzJOHDVzTwuG+PQapNyuFhC5rKXdL3StI6guuIRk1zy/jwxb
         50oTcnOh7uepnErAgfSUJZ1yxiEeG84MZ3eCSmRzk+0k3nW9dSr2qJVmvHk/M14IMgLO
         /OCORUNwCsWHk3JUEFffLL9FBKHDulbnD41mjXtxo8Ckk3vl5t68svoS0ahhZ9RXuTQE
         vIKVO1NoMzEOisxCGTAVzICGYUvZsqWfyTK+LgRppKYBiQX9JmZkoBNk0hFAzo73mnL0
         3aQluBYwjATKHOZY3pR/JMaXVLlBLdHZWW+uMxLdvaCufKlKwii4sOYIkR4Nji81f6NJ
         qM1g==
X-Gm-Message-State: AOJu0Yxo/SUR0LVv5J8U7vZk9xEYq0T5H9pQ1aTRRXoVV5GI711JjxDn
	GFl/vARQBVw7ouzAEl7zBXrkLvRlNEJpLYxK0/sVm5p/u6aXUpWKlJAU/GCEqE3y+KPoOGfmNQ6
	nyjeVSNMpahQFXOrS72I6VGCPNZDLMlxYgnVTMDe46gvjO4gELGLIYTfXOA93bTNy6A==
X-Gm-Gg: ASbGnctR/tPfRhzQJR48VFhDNOnjfoomU7uTa4/hVmNkc+foF6nDiP+EaRhi9arPSyw
	C7usH25qbxsdXMOX+fXpiHq/7kzAWcknCzqLPi8SRV79GVXQEr6NdkooneiMJJd8XgVz8oVkQ01
	HOYpmWTyogq+6/reWrBEmJDZCLzoawq2hdhC8CtyQr1odIXiwJgXpDi7IISwbAvdLp9kkYUAMQX
	7sJjD0BVRbdG9ULEvcWghU1pwXiGNgZF/l2D219kKJs9BPWstNKsCBKvWpAGp9UInDhA7Oj3BOl
	nq40YJCAZsZ10OFGVzI+Gmq7vdqLmGrb3wvi6BAxPn0M
X-Received: by 2002:a05:6e02:20cc:b0:3cf:f844:68eb with SMTP id e9e14a558f8ab-3d17bdff4afmr78549435ab.4.1739479842203;
        Thu, 13 Feb 2025 12:50:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDMe7E1JVdXDBUr6XZRz5GyntXhpvAi3zXJ6MAgZ2nvCsKmDeV88O+2d3l8BxyDsAiQ9639g==
X-Received: by 2002:a05:6e02:20cc:b0:3cf:f844:68eb with SMTP id e9e14a558f8ab-3d17bdff4afmr78549375ab.4.1739479841888;
        Thu, 13 Feb 2025 12:50:41 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed28149500sm494082173.2.2025.02.13.12.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:50:41 -0800 (PST)
Message-ID: <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
Date: Thu, 13 Feb 2025 14:50:40 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250213195129.GZ21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 1:51 PM, Darrick J. Wong wrote:
> On Thu, Feb 13, 2025 at 12:06:24PM -0600, Eric Sandeen wrote:
>> A bug was recently fixed in exfat where attempting to do a zero-byte
>> write would yield -EFAULT; test for that here.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/tests/generic/761 b/tests/generic/761
>> new file mode 100755
>> index 00000000..e933eb83
>> --- /dev/null
>> +++ b/tests/generic/761
>> @@ -0,0 +1,28 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test 761
>> +#
>> +# test zero-byte writes
>> +#
>> +# exfat had a regression where a zero-byte write to a file would
>> +# yield -EfAULT. Should work on all filesystems - write should
>> +# succeed and the zero-byte file should be created.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>> +
>> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
>> +	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
>> +
>> +# Modify as appropriate.
>> +_require_test
>> +
>> +rm -f $TEST_DIR/testfile.$seq
>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> 
> When does the file not get created?

In some unknown error case? ;)
There's probably no reason for that test, though of course
it's still expected to pass.

In the various discussions of the exfat bug scattered around
the internet people kept pointing out that "well, the file does
get created" so I probably had that on my mind.

-Eric

> --D
> 
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/generic/761.out b/tests/generic/761.out
>> new file mode 100644
>> index 00000000..72ebba4c
>> --- /dev/null
>> +++ b/tests/generic/761.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 761
>> +Silence is golden
>>
>>
> 

