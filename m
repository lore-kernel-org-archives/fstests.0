Return-Path: <SRS0=sDCH=Z4=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07DDC43603
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Dec 2019 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375B2466E
	for <linux-fstests@archiver.kernel.org>; Fri,  6 Dec 2019 15:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih6zlvc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLFPcf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:32:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbfLFPce (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Dec 2019 10:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575646354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vrRHGPYmjcTM0XZC8UNoHhF8C8DOYU45Fu5tYyP/hQA=;
        b=Ih6zlvc7f2XuEfm7LvhNaWeFF/01tbB5hXzs9SDdV/7F49ElkRmKy97GpIaWf6iulaEih/
        p6Zj9O42j5hGsdGPV1X6a4bIUI2awb08LgZkaarGgc67CR0h26cndFvdUcg/rOBpw5EtwU
        v7Z+ZVUmHUE0O/EdFSjZbhjc4T/0R0k=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-iGEZid56N_C4h5xAYhJoQQ-1; Fri, 06 Dec 2019 10:32:32 -0500
Received: by mail-oi1-f197.google.com with SMTP id 23so67791oii.4
        for <fstests@vger.kernel.org>; Fri, 06 Dec 2019 07:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kSj30NZ4slRVLhG11NpWfTALn0mUTBYqBl4220+YO5g=;
        b=Nky4SAoEg8Eb9QHFaDlbsos7NkyT+oSG5UEfZqrhgrwgbZ1fQ1RtT2FPDLHRohHKIQ
         lKNkpEjKua2EBUNFlX9lY5eDTkCBA5AhLp7oFm4RuIsWwNTLrYWPA3gM1AmvFDD8ibj7
         JEcNHKgkodKz0X/U8w6bPedM1f9w2KwZXiNAe4av0Tz3i9OTEDO+RTk7T9drDD2XKtkU
         43386HYN8l+/QT7rkIxw/jIslGOEyIToD7xIdxL77NFPjR7gRFksC+DIq+1NmAmgqFiH
         2eKk5onOcfzZGcHfKzkZBHRX8E9wH1Ib7i3IW6RbQPYtfmtDPB1EN/rFgQ650DOdtkUe
         mVlQ==
X-Gm-Message-State: APjAAAWN04aCnsa/nL0IjVya+jt2D+7/MIAP4uKR7wzP+6UGltCJpCDb
        pvUmTLw1haaXT6GkUJLp75ilW5YK4Qwq1P3f9FwKMbiKG8QsFKWx9It7Q8MbyYutfpFn6dGRmzC
        fSWSrLwTtlPU4Si9qlMDorFmIsjKUjZv7IQ==
X-Received: by 2002:aca:4e90:: with SMTP id c138mr12821903oib.147.1575646351370;
        Fri, 06 Dec 2019 07:32:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdJNsSuHajakas0kMY45NJw8UyyPFxBH1fDI/Kgwr43XMxlZXh4LAlIW3tukCj6X/thZ80bUvvvudgJoc2C1I=
X-Received: by 2002:aca:4e90:: with SMTP id c138mr12821868oib.147.1575646351091;
 Fri, 06 Dec 2019 07:32:31 -0800 (PST)
MIME-Version: 1.0
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 6 Dec 2019 16:32:20 +0100
Message-ID: <CAHc6FU6ZbWL_LhZ_p1c=gAiD9VAjkPCMT01pqkcTSO0V9s9OgQ@mail.gmail.com>
Subject: Fwd: fio verify and short writes (resend)
To:     fstests <fstests@vger.kernel.org>
Cc:     fio@vger.kernel.org
X-MC-Unique: iGEZid56N_C4h5xAYhJoQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

[This basically is a resend of https://www.spinics.net/lists/fio/msg08165.h=
tml.]

I've run into a verify issue with fio in xfstest generic/300 [*]:

The filesystem I'm running this on has a block size of 1k, on a
current mainline kernel and with current fio.

The aio-dio-verifier thread in that test case writes 4k buffers and
then reads them back in.

The test case is designed to run the filesystem out of space. When
that happens, some writes can end up short. That doesn't seem to
happen on ext4 or xfs filesystems with a block size of 1k, possibly
just because the test always runs on a scratch filesystem, but it
does happen on gfs2.

When the aio-dio-verifier thread reads the buffer of such a short write
back in, part of the buffer will lie in a hole and be zero-filled, so
verification will fail.

Any thoughts?

Thanks,
Andreas

[*] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/gener=
ic/300

