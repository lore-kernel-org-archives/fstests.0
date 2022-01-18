Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E5C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiAROCQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244509AbiAROCP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 09:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642514534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aseNuAEU4MfGH9/zhC0kgmCKIT6DQ1Y52t+zCSQKPog=;
        b=VrD9lJO9Dwr4gzPGqGowb1o/YD6xvPLeWCWa6C85c5JNVeKfplbjJVPMPfi0QYZmwEgywG
        ydcJDGSBh58J2RwNapcWWJVRzHRuNZMX9FeUvgNIO2p3XNsy6My2ZGzI+a+KQhSp2usy5/
        5H/K4tfknSsIBkhF5AevwSBtq00+7NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-Zy4FNwm3MNu8KxWWjw3yEQ-1; Tue, 18 Jan 2022 09:02:13 -0500
X-MC-Unique: Zy4FNwm3MNu8KxWWjw3yEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF7B5101C7A2;
        Tue, 18 Jan 2022 14:02:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD26F78AB5;
        Tue, 18 Jan 2022 14:02:10 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "xuyang2018.jy--- via Libc-alpha" <libc-alpha@sourceware.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
Date:   Tue, 18 Jan 2022 15:02:09 +0100
In-Reply-To: <61E64FED.2010906@fujitsu.com> (xuyang2018.jy's message of "Tue,
        18 Jan 2022 05:27:10 +0000")
Message-ID: <87r195i1lq.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

* xuyang2018.jy:

> on 2022/1/18 11:56, Theodore Ts'o wrote:
>> On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
>>>> You're right of course, but out of curiosity, which C library are you
>>>> using?
>>> I use glibc-2.34.
>>
>> Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
>> shouldn't have been set by any prior system call.  I'm guessing maybe
>> it was something in crt0 which ended up setting errno?
> It maybe a glibc bug.
> I cc glibc mailing list and see whether they have met this problem.
>
> @Florian
>
> Now, I use glibc-2.34 and run the following program[1] but the errno is 
> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
> doesn't meet this problem on glicb-2.31)?
>
> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c

I'm not aware of this issue.  Could you run strace or strace -k to see
where the failing system call is coming from?  Thanks.

Florian

