Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D695C001B0
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 15:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjHNPMJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjHNPLu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 11:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955910C6
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692025847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12HC6JD2O0bLtp7WyRFPXIoci6YJsDgOuX51lZJptGg=;
        b=GuJm+jJ/g13dkx9G6TSFi5eBQ6bhpKYAFY9LsHsxgChMOHZQdkvkvv2bV5lJooWqGUQiOl
        NnrESInehl4hRUG/SvcSdsI/zdqQ2MLqrOhEDiexkIO4AeM7LeNKRciC/eXeSf0lQBTos5
        IgCGXHHicWe6xXLJ5AErklB9Fb45pHk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-_HAliwNZNReGrHig8jMsgQ-1; Mon, 14 Aug 2023 11:10:45 -0400
X-MC-Unique: _HAliwNZNReGrHig8jMsgQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5a7e981ddso4708858b6e.2
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025845; x=1692630645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HC6JD2O0bLtp7WyRFPXIoci6YJsDgOuX51lZJptGg=;
        b=EYsVtR58A8UPPYYkIBruwAvB4spddlgGB/ZT8xAKWkh26Hfpla+EsOosi2Ad7XrMmM
         ArFCXTFFvcAxAng6X3sqrTrJ0c22U1VeEnCRCHCuzDWs7qsj+xqM9mrEZRoJL7OP8wS9
         +oFhLLPetHH9yFUV/aGtvN6xlTUj0cyJqKrYEMzKdZhSaZ2vwaoAfra2vbBMyKt2C5Ix
         u7vsic8qGGZa45+6++8dwz4u1cAaH/oOjP+QsP+wqPC0ch9kr2xdhIkQhbBQVnNds/81
         JfZddfsHERe/pYRX3yJVySri9/VsTOCLmFTDo6tXUXkR/fYCw7pPZoBFS/XqDYizZLj+
         x98w==
X-Gm-Message-State: AOJu0YxI+Fw+PNfaePesdFGYEHHOU2ktO8bNULiity9Xe+jR2IHdhSkY
        REoZzMgNHgFVFCcwzSh3cljDtXgAW0Rh5Hg1R2c95nWKW26uHPzwRH2cp2m7C/eW3m+3dFNdqOV
        1hBb/XkAxeaKskELt8Q==
X-Received: by 2002:a05:6808:1302:b0:3a7:4478:7139 with SMTP id y2-20020a056808130200b003a744787139mr14038503oiv.1.1692025845286;
        Mon, 14 Aug 2023 08:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8QEE4IjurHEwQU6rrBLlxlxgWhg5PWd4F+u20NyunPPOuFzXd/X80EdVLIk+kfSN2UDWlMw==
X-Received: by 2002:a05:6808:1302:b0:3a7:4478:7139 with SMTP id y2-20020a056808130200b003a744787139mr14038485oiv.1.1692025845035;
        Mon, 14 Aug 2023 08:10:45 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a63954c000000b0055fedbf1938sm8762083pgn.31.2023.08.14.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:10:44 -0700 (PDT)
Date:   Mon, 14 Aug 2023 23:10:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix parsing expunge file with comments
Message-ID: <20230814151041.qakfinobofzlbyth@zlang-mailbox>
References: <20230813140950.678899-1-amir73il@gmail.com>
 <20230814145015.6w6l2y7dxt4opvov@zlang-mailbox>
 <CAOQ4uxha+18YG+LrX76-2BUxuyTYcZ=9+cJOoCGpnLSC21Sxrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxha+18YG+LrX76-2BUxuyTYcZ=9+cJOoCGpnLSC21Sxrg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 05:54:45PM +0300, Amir Goldstein wrote:
> On Mon, Aug 14, 2023 at 5:50 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, Aug 13, 2023 at 05:09:50PM +0300, Amir Goldstein wrote:
> > > commit 60054d51 ("check: fix excluded tests are only expunged in the
> > > first iteration") change to use exclude_tests array instead of file.
> > >
> > > The check if a test is in expunge file was using grep -q $TEST_ID FILE
> > > so it was checking if the test was a non-exact match to one of the
> > > lines, for a common example: "generic/001 # exclude this test" would be
> > > a match to test generic/001.
> > >
> > > The commit regressed this example, because the new code checks for exact
> > > match of [ "generic/001" == "generic/001 " ]. Change the code to use
> > > prefix match to deal with this case and any other suffix correctly.
> > >
> > > While the original code would also match line "exclude test generic/001"
> > > I don't think that non-prefix match is a real use case.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  check | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/check b/check
> > > index 549725eb..e8152f59 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -592,7 +592,8 @@ _expunge_test()
> > >       local TEST_ID="$1"
> > >
> > >       for f in "${exclude_tests[@]}"; do
> > > -             if [ "${TEST_ID}" == "$f" ]; then
> > > +             # $f may contain traling spaces and comments
> > > +             if [[ "$f" == ${TEST_ID}* ]]; then
> >
> > We'll have seqnum with 4 numbers in one day, likes generic/1000. At that time,
> > generic/100[0-9] will match generic/100*. That's not what we want.
> >
> 
> Good point.
> 
> > I think we'd better to do exact match, or better to match the end of a word,
> > for example
> >
> >   local id_regex="^${TEST_ID}\b"
> >   if [[ "$f" =~ ${id_regex} ]];then
> >   ...
> >
> > I think this will match "generic/100" and "generic/100 # xxxxx". But won't match
> > "generic/1001".
> >
> 
> Nice. Looks good to me.

I didn't test it, please check if that can help you and won't break old things,
if you'd like to write that in V2 :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
> 

