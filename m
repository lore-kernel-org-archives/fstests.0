Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A88EB64DC
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Jul 2023 15:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGCPGJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCPGI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Jul 2023 11:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A8AD
        for <fstests@vger.kernel.org>; Mon,  3 Jul 2023 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688396720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFrjKzKMW4hiNxjoWbL1/BUxT1klpDswTQpEw9o4PjI=;
        b=RbgK+qYbeELat/NUnyRGntBcTyxL93K8itiYYjyju8hNSS7+q8Sl0is2V78TiSEOc7xS4l
        MrpR65vfZv+PVYqwqhtDgZYrr7bq7xFQQBNthWHukYBNaGNoLzRUBGNQielYb+1bOK/bL+
        Npw7stk/ONkVblpWH3tdKcvyUOWzzDI=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378--g5z839yM5q2aJfzHaOcFA-1; Mon, 03 Jul 2023 11:05:19 -0400
X-MC-Unique: -g5z839yM5q2aJfzHaOcFA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-666eb0346c4so4150263b3a.0
        for <fstests@vger.kernel.org>; Mon, 03 Jul 2023 08:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688396718; x=1690988718;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFrjKzKMW4hiNxjoWbL1/BUxT1klpDswTQpEw9o4PjI=;
        b=l0EhqjNopXesL8eaeRP2fzPGGcHLqsJobs9hfYsMA+76wIXJr/j/QzRY/+biV199ct
         fkeuHBy0VVcAiNBzdlo69J9HmV5Atz/Ql9GJyvrSRdUxcMbOsmsnOsu1NVjqBFC0dSl+
         0SbKJ5pGUjkQVE/BGtkltsCrTyW3RI0qebtnjI3p1QAyXe2oeQhk3heBRq5unewuGWJK
         kfQ4wZqQG2XLYeqBzX1Y5gbc5WcfBvzyJrb5mBZWkgtSsAueTj5Xb++gYI/kiEoc/dZl
         fh5NYdV/mAHyj+t9Tmb0C761l3hVH9rQKbFzGXpCTg9KvnaxaLxon+3r3/xCC855r4eP
         V+zA==
X-Gm-Message-State: ABy/qLbMRHlGNKwze12lhpIw3WVhTMFVNMGDmuXu1SzY4ihzW37hCF33
        bWlXG0/tFYGWsABTwlWMoh4WwJ3r7BYA0UtG7+pUUZZs5/py/EVF1ZdnpmZuXppx1ZgkjpgAuEG
        SF5m6Sq00pZu0n3Gb7A==
X-Received: by 2002:a05:6a00:2346:b0:673:5d1e:6657 with SMTP id j6-20020a056a00234600b006735d1e6657mr11763280pfj.7.1688396718021;
        Mon, 03 Jul 2023 08:05:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFHzB8pQLgCfvv4FoK6y7CImoX1eVwcleF+EhKRXSQXaavFysyYzuuMPa7YrvGL8u4U0BKx1g==
X-Received: by 2002:a05:6a00:2346:b0:673:5d1e:6657 with SMTP id j6-20020a056a00234600b006735d1e6657mr11763224pfj.7.1688396717503;
        Mon, 03 Jul 2023 08:05:17 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m18-20020aa79012000000b0064fc715b380sm14576472pfo.176.2023.07.03.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 08:05:17 -0700 (PDT)
Date:   Mon, 3 Jul 2023 23:05:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     stsp <stsp2@yandex.ru>
Cc:     fstests@vger.kernel.org
Subject: Re: generic/478: why eval is so fast?
Message-ID: <20230703150513.tgxij5svjxucpib5@zlang-mailbox>
References: <817817a1-2f2d-1ee1-0898-f86801586d65@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <817817a1-2f2d-1ee1-0898-f86801586d65@yandex.ru>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 30, 2023 at 02:50:47PM +0500, stsp wrote:
> Hi guys.
> 
> While playing with the test 478, I've
> noticed something very strange. Namely,
> this small patch, that only adds eval to
> the script:
> 
> diff --git a/tests/generic/478 b/tests/generic/478
> index 480762d2..45b801d0 100755
> --- a/tests/generic/478
> +++ b/tests/generic/478
> @@ -106,24 +106,24 @@ do_test()
>         # print options and getlk output for debug
>         echo $* >> $seqres.full 2>&1
>         # -s : do setlk
> -       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
>         # -g : do getlk
> -       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>                 tee -a $seqres.full
>         wait $!

I didn't find out why it run faster, but I'm sure we can't merge a
patch which only say "it's faster, but don't know why". Especially
that "faster" is really unnormal.

One thing I'm confused is about that background process, if you add eval to
that line, can you sure the later "$!" (in "wait $!") is the t_ofd_locks
process number?

The second eval with "| tee -a  $seqres.full" confused me too, I'm not
so familar with eval, can't what kind of problem it brings in, but I
doubt something wrong at there.

Anyway, I can't merge a patch like this. But I don't mind if anyone
can answer this question :)

Thanks,
Zorro

> 
>         # add -F to clone with CLONE_FILES
>         soptions="$1 -F"
>         # with -F, new locks are always file to place
> -       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>                 tee -a $seqres.full
>         wait $!
> 
>         # add -d to dup and close
>         soptions="$1 -d"
> -       $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> -       $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
> +       eval $here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
> +       eval $here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
>                 tee -a $seqres.full
>         wait $!
>  }
> 
> 
> speeds up the test by 50-60%!
> This is quite unbelievable, and probably
> means such change breaks something.
> But I have no idea what and how.
> Can anyone come up with a good guess?
> 

