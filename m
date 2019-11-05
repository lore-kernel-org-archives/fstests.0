Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149BC49EAA
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF2C21929
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 09:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Dw49I8qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfKEJXm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:23:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46957 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfKEJXm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Nov 2019 04:23:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id h15so10774540qka.13
        for <fstests@vger.kernel.org>; Tue, 05 Nov 2019 01:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=YkhaHXSsDqirPfbF2CFOp3B+1zltTG0E4zKqdP/VC+c=;
        b=Dw49I8qifVDCORWLRdtpBY9ooKcZxEjz2rc/KtxMb3rpM9VgH9M9vzmE0C99ph48hG
         B4DFLdKLK/Iezm85RKrniMhZYCNoCU2AfUjlyOsNy3vbPTaSzk7Ag57GCgNsshy03qTd
         Oe87p1SLyxn+tTUhfeSrz/DJmY9lFundHyKQQs1r5dVdvtRZ8NSMHlURt3EsfrLuAUW2
         82N13FPIgVgdGIQc+sY4MdguhhPxCg+zkF413zNlN5CbAfX5wBxwePrIs4OtP9Pr8YAf
         b0WBAjnmLyH9S/hAsy9nDql1h8n6wf6IkiOmolfN4f4mAxWiRr9lYBDisfaGOtyR+ULj
         Rn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=YkhaHXSsDqirPfbF2CFOp3B+1zltTG0E4zKqdP/VC+c=;
        b=OmRs0S7Xwor18TciKx4fRLdhjdr26IY5kqsKuzitgxGNYBCinunQvjmcLnEIw2pdui
         EWUEWAeag27yGLSGT3Q9zeZ1SXxUaaycAXYYpM03HVRIEGMIrF7N+xvB/PqmNuaihOVK
         7dB4DKINpCw9J6o8TYcjHaUF6M2RUNyPtDq5M+xSn0c1r0vW2DhALL4mbyn68zyNF6PV
         VsrDexD8xTGgpDPXLA2qmhYTsIOnvD53/KcPFYp+TF8qcRYvJs0h1bK7Yygv14wZy/jE
         xSP+waerWUp4Q3XWC5OTtbO6TiT6NTh5svL//arhg5P1F519ATerHHEyGQJOTKZhfg1m
         A+8A==
X-Gm-Message-State: APjAAAUHi7PySJW78ICz1qsOA5Nqc0V8goW4KKPLmzT8DPC5H1TlA2X/
        W5+maig9SBwKAFZNKqG/9sRDxial90yxDg==
X-Google-Smtp-Source: APXvYqytwCb3ZVQn9qLgXXk+sTvXDqBUutYEvS0fjTCi17iuFjOtgFUudKA9oaz/cAwAyjiut+zA0g==
X-Received: by 2002:a05:620a:a85:: with SMTP id v5mr9941501qkg.471.1572945820720;
        Tue, 05 Nov 2019 01:23:40 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u27sm12218079qtj.5.2019.11.05.01.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 01:23:40 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: 5.4-rc1 boot regression with kmemleak enabled
Date:   Tue, 5 Nov 2019 04:23:39 -0500
Message-Id: <036DEC84-92EE-4A47-B078-ADC605482255@lca.pw>
References: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Theodore Tso <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAOQ4uxgy6THDG2NsNSQ+=FP+iSZKeCkNEM9PbxQSB5p5nHvoCA@mail.gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
X-Mailer: iPhone Mail (17A878)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



> On Nov 5, 2019, at 2:14 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> My kvm-xfstests [1] VM doesn't boot with kmemleak enabled since commit
> c5665868183f ("mm: kmemleak: use the memory pool for early allocations").
>=20
> There is no console output when running:
>=20
> $ kvm -boot order=3Dc -net none -machine type=3Dpc,accel=3Dkvm:tcg -cpu ho=
st \
>    -drive file=3D$ROOTFS,if=3Dvirtio,snapshot=3Don -vga none -nographic \
>    -smp 2 -m 2048 -serial mon:stdio --kernel $KERNEL \
>    --append 'root=3D/dev/vda console=3DttyS0,115200'
>=20
> $ kvm --version
> QEMU emulator version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.19)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>=20
> Attached defconfig saved by 'make savedefconfig'.
>=20
> I tried increasing DEBUG_KMEMLEAK_MEM_POOL_SIZE, which did not help.

It probably use a bit more memory than before. Does lower the parameter help=
? Eventually, It should boot with POOL_SIZE=3D0, no?=
