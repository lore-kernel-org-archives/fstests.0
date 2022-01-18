Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07885C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 11:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiARL1C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47340 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239702AbiARL0n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 06:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642505202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8FLsSzaNb6xBwgmP5aI7qiq8CRn4bfPKFs/xZ3Nci08=;
        b=UXGXiDMGh5cuFSzPyrNWvpt+pFKeHKzBwdKKSau0dSda0CeNKknFcT3GkGYvxIcPuAgyXp
        /5S7F0AA7gMxZm/NIYEI1w/mCWBmaYgs58M2W80PZaVwgbjIxQZS3qnpISGVVH2LZE0ES3
        X3YyB8Bq65MNqyonoV2zLAQEocJKeV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-RtW3k5-IMsepvasdIX3Nog-1; Tue, 18 Jan 2022 06:26:40 -0500
X-MC-Unique: RtW3k5-IMsepvasdIX3Nog-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 746951006AA3;
        Tue, 18 Jan 2022 11:26:39 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D6B752DC;
        Tue, 18 Jan 2022 11:26:37 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/ext4_resize.c: set errno to 0 before the strtoull call
References: <1642405014-3287-1-git-send-email-xuyang2018.jy@fujitsu.com>
        <YeYmzJG5M0y9BcMc@mit.edu> <61E6298D.80006@fujitsu.com>
        <YeY6Uh8I7RlsCicw@mit.edu> <61E64FED.2010906@fujitsu.com>
        <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org>
Date:   Tue, 18 Jan 2022 12:26:35 +0100
In-Reply-To: <eef02950-b7c2-8ab8-1e19-165383fa99b9@linaro.org> (Adhemerval
        Zanella's message of "Tue, 18 Jan 2022 08:23:25 -0300")
Message-ID: <87wnixjndg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

* Adhemerval Zanella:

>   
>
> On 18/01/2022 02:27, xuyang2018.jy--- via Libc-alpha wrote:
>> on 2022/1/18 11:56, Theodore Ts'o wrote:
>>> On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
>>>>> You're right of course, but out of curiosity, which C library are you
>>>>> using?
>>>> I use glibc-2.34.
>>>
>>> Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
>>> shouldn't have been set by any prior system call.  I'm guessing maybe
>>> it was something in crt0 which ended up setting errno?
>> It maybe a glibc bug.
>> I cc glibc mailing list and see whether they have met this problem.
>> 
>> @Florian
>> 
>> Now, I use glibc-2.34 and run the following program[1] but the errno is 
>> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
>> doesn't meet this problem on glicb-2.31)?
>> 
>> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c
>
> The errno should be only set on a failure, no function shall set errno
> to 0 (it is a POSIX definition which glibc adheres).  The application
> need to explicitly set errno to 0 before the function call to check if 
> an error occurs.

While this is true, I think errno should still be 0 at the start of the
program.

Thanks,
Florian

