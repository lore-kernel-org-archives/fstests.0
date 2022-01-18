Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC46C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 12:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbiARMAb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:00:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237808AbiARMAb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 07:00:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642507230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7r1DB4FXNVsU5Chl8eXc+djUPnLLLz7oZKsglp3Zmk=;
        b=V86H+Fq9W3RQITRXUlPt9DyS9LOOphil99tua0P07ysCAzAKJfBZu5wk2P3LCTMJH9SErO
        GCbAVLEqu/NIH5txvbcQN/nTHESYfXHvI4tMml4spw3K7iUMC7lh21doX///5SJw5eXw8C
        a7f8HvgBcwa1aF61Xrl2RToC+xU3PXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-udLWtZi9PF2xuM_S_0iLIA-1; Tue, 18 Jan 2022 07:00:27 -0500
X-MC-Unique: udLWtZi9PF2xuM_S_0iLIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D82141006AAC;
        Tue, 18 Jan 2022 12:00:25 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4699752DC;
        Tue, 18 Jan 2022 12:00:23 +0000 (UTC)
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
        <87wnixjndg.fsf@oldenburg.str.redhat.com>
        <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org>
Date:   Tue, 18 Jan 2022 13:00:20 +0100
In-Reply-To: <496a3521-5a0c-b3ae-29bb-02fd0056525b@linaro.org> (Adhemerval
        Zanella's message of "Tue, 18 Jan 2022 08:49:40 -0300")
Message-ID: <87h7a1jlt7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

* Adhemerval Zanella:

> On 18/01/2022 08:26, Florian Weimer wrote:
>> * Adhemerval Zanella:
>> 
>>>   
>>>
>>> On 18/01/2022 02:27, xuyang2018.jy--- via Libc-alpha wrote:
>>>> on 2022/1/18 11:56, Theodore Ts'o wrote:
>>>>> On Tue, Jan 18, 2022 at 02:43:26AM +0000, xuyang2018.jy@fujitsu.com wrote:
>>>>>>> You're right of course, but out of curiosity, which C library are you
>>>>>>> using?
>>>>>> I use glibc-2.34.
>>>>>
>>>>> Hmm, ok.  I'm using glibc 2.31, and in this particular program, errno
>>>>> shouldn't have been set by any prior system call.  I'm guessing maybe
>>>>> it was something in crt0 which ended up setting errno?
>>>> It maybe a glibc bug.
>>>> I cc glibc mailing list and see whether they have met this problem.
>>>>
>>>> @Florian
>>>>
>>>> Now, I use glibc-2.34 and run the following program[1] but the errno is 
>>>> not 0 in the beginning. So is this a known bug on glibc-2.34(Theodore 
>>>> doesn't meet this problem on glicb-2.31)?
>>>>
>>>> [1]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/src/ext4_resize.c
>>>
>>> The errno should be only set on a failure, no function shall set errno
>>> to 0 (it is a POSIX definition which glibc adheres).  The application
>>> need to explicitly set errno to 0 before the function call to check if 
>>> an error occurs.
>> 
>> While this is true, I think errno should still be 0 at the start of the
>> program.
>
> I think this is a implementation detail, I am not aware that either C or
> POSIX now states it should initialized to any specific value (in fact, 
> POSIX at Issue 5 [1] has removed the 'The value of errno is 0 at program 
> start-up' on its description).

It would be nice to stay compatible with that.

> In any case, we set errno to be an uninitialized TLS variable.  Unless we
> have a bug on .tbss initialization I think the issue is somewhere else.

I suspect it's some additional system call, which is why I requested
strace output.

Thanks,
Florian

