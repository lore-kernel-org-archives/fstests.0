Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB23806A3
	for <fstests@vger.kernel.org>; Tue, 19 May 2026 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171314; cv=none; b=q2poY5YUiulfIk4wFYgxTGlvbfyxrtG2xTOivCpaFyNDMeUl5gXvS9SJ5eFr1jJtoR9ACDxf+tfe2swNTF1teVzXj6Dcp7WY4ZFBrZqpkvk+irJz1eiJ/RY0YorkUx+/6nRJGM1z9UyCkF8yojUZZvsCkb+aPoPT4il39x/pwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171314; c=relaxed/simple;
	bh=mm7k25tlmn4xkTO8xL313/O6AZxpv3Ovc4fBIijl5iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbGc3sW+/qbVmMhk+5LzeAvQu1pr7XNx5os6LKcFgTD6wbqK+E4gjUncnK4akAxFGFX0rstoiWtj6RKPvIga6GR/XdB3OCJ4gOh3jiBIHyAsMdcyptvdOYM54KKcmm6mghZmuHvYc58xcd6xCHo581i7N/+nLP1wodza7iqmlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3UJIkHv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3UJIkHv"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1315607a12.3
        for <fstests@vger.kernel.org>; Mon, 18 May 2026 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171313; x=1779776113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsnCMoFb4eb7A398idYgiUXDd+PPPCKn8DaQJvFslBc=;
        b=s3UJIkHvAFnjKtNi3oxoWd3jN3pZ+u7/XVIWxWfNvFloxfXozZL+whyrc29SP0W0VU
         lunHfD+A2yzBpk6lE57LsBJ7ZJBh6OsFp81VIeDBo1gs3CCRU0XjtT9NYL4zb/Kr1wg1
         vcQtH+9yrdkEvg3R3AfcdQoJbYYsU3mm3s7bziBBNHpm0rpb3alLW2LNOypJA8tbZ3DW
         U8VSV2LJC6Y2YSaFyAschl+dfgfpO4l+pT6O08a/Shve8zSqQZqqmJ8UZNOpejsXp742
         FtbJypALcR020lV7ncTqt4I5nZhisJpfHoWXkwqzpMeBrbdb+HRz4+dKgAWsED99yTd/
         yjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171313; x=1779776113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsnCMoFb4eb7A398idYgiUXDd+PPPCKn8DaQJvFslBc=;
        b=Q4CChJW//wbs49G0QMtiUFuX5Gk6qIP4JKy9teZX/Uzw0PObPppFvtLVFHsDbFnkz4
         CuZht8rcExgQMomK1I/4VqbfOgSV5HDdElv89R+wGWFQtYM2ANBSvLkaFC4RRaeK35j4
         nagj5X0l5027DLh4P7zCzHICLgTEE1RUTGhMmocLXuGeVYXQxX7LPCm54xFTdon1MEfW
         3IdYaORczfbFXQnOkZ80qgkQJoEh+ieH6Gjpf55+YghUIcebiTbul0P3h9qIDpYpZ/XS
         v0IksT+4RoGX33YkwrX130pOqeETYbj5syidUWt+4EZdAOobS19EuMkBXgBS83JvLCiy
         UZbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7pAvG1RKiVC7AVFu6Ck6sQxS5w+Y0W2Bv5kweeIwXy5Q9yANUdv2pQ5flRcDEGkdMHcaRUhic@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/XJK2C6ilihRrTIKfA8ukpbUFi7AV3/oKvNNx26ONTjNPggH
	zP79RSJhddaMhRpD/gI8dRZR0iwIOttZYfjXvcH1BY7L33y6PljBrVUF7mM+Ew==
X-Gm-Gg: Acq92OHaZUn//zqDxBLTk8n0UpX18PFlKz43Esyq5BHAlsXYyJdwNdzEu4BeSMjyZe4
	bjIq7Djo55a1ps9FG5iCjtik/Sf0x8WoIWYCkVM2ZX3f0EL1fxyZHqD0ju0VrvA5UWaciv1iUAC
	RWw/TnhM5j7WJA475rof+bRv4f64tGrmiiTMemSulW5Ouk7LkyuSDK/K2V7/oXDposQXUlykszW
	l9pt/l0UADEjuP3Fo77nTAONRQJQlK2PA+FDtFC5Yns7D3kH8pIj5EeP5XVp/PERRzfd+BDOshn
	VxMyiqjvBctVnBSXrms48yIkZ7scYLCbLF1AIsm8WEqKdRoH95eaofTrgRP+yV/wVG9+mcdrRLV
	4fD4KrUcBpR5DmAbUR+cdWQGbnoNnischlUn4+EkH74B1lo4ke1N/M+Wkhyi2eQe24eQuyanSzO
	slcj/VizMTkZGUlosDGhkE7xY4OgyPkw==
X-Received: by 2002:a17:90b:134e:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-369519c348cmr17621871a91.10.1779171312574;
        Mon, 18 May 2026 23:15:12 -0700 (PDT)
Received: from [10.203.107.185] ([129.126.14.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm12985043a91.2.2026.05.18.23.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 23:15:12 -0700 (PDT)
Message-ID: <24280a77-8119-4b00-87e4-223ffded1b92@gmail.com>
Date: Tue, 19 May 2026 14:15:09 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: test qgroup deletion races with squota writes
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1778632843.git.boris@bur.io>
 <2c8668284ded13c7cc63ece213d9e1edc3e6ea85.1778632843.git.boris@bur.io>
 <e29e3b26-bd22-41d7-92f0-8d89bf73f5ea@gmail.com>
 <20260518162841.GA3181893@zen.localdomain>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20260518162841.GA3181893@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



Boris,


The 7.1.0-rc3-gf5d9f327e4b2 kernel includes the for-next tree
plus my latest f_fsid kernel patches.


I double-checked and the required btrfs squota patches were
indeed present:

$ git log --oneline fs/btrfs | grep "check for subvolume before"
404bf5a24f2e btrfs: check for subvolume before deleting squota qgroup
$ git log --oneline fs/btrfs | grep "forbid creating subvol qgroups"
0c309d66dacd btrfs: forbid creating subvol qgroups

Possibly the issue was likely my messed-up VM image from
SELinux + fanotifywait troubleshooting last evening.

After a fresh restart, btrfs/348 passes:

$ ./check -s gen btrfs/348
...
Ran: btrfs/348
Passed all 1 tests

Sorry for the noise!.

Looks good.


Reviewed-by: Anand Jain <asj@kernel.org>

A small nit (which can be fixed during merge).

>>> diff --git a/tests/btrfs/348 b/tests/btrfs/348
>>> new file mode 100755
>>> index 00000000..ab816301
>>> --- /dev/null
>>> +++ b/tests/btrfs/348
>>> @@ -0,0 +1,136 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
Do you need this to be   `s/2024/2026/`  ?

Thanks.


