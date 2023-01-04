Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F367C5479D
	for <linux-fstests@archiver.kernel.org>; Wed,  4 Jan 2023 10:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbjADKzy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 4 Jan 2023 05:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjADKye (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 4 Jan 2023 05:54:34 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACD12D33
        for <fstests@vger.kernel.org>; Wed,  4 Jan 2023 02:54:09 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id tz12so81638173ejc.9
        for <fstests@vger.kernel.org>; Wed, 04 Jan 2023 02:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pxje+5aTPq7eSsg/ruQa9jMt63AcUe76/mSIdF4YJI=;
        b=YM3xFzYuhdejV1kQQWYoy9azE8HGcWtLEDyFAmyaAyq7yNt7SaXnu1fEU6JLN+rsHz
         Yp821Cc29nKyLdyuS4DKbnlYMjv12T9tO78CAn5QdARPvTPb+ulGuCUQzMz9rx+s62Ny
         CV7qt96ZBVyvSEXAvuhOYan5caogNaK9pKDsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pxje+5aTPq7eSsg/ruQa9jMt63AcUe76/mSIdF4YJI=;
        b=D0Dn7pCIlyxGzWsE1rdG3M9OkhOZaCuZIXAPi+kdNRV8m62vRaNnBEzocmqwlV0U+D
         sJuxe9hw9xBJeW9Q8ULmCMsJ6x22+9pz/fXMN8XdmD4BgzbMzjwrJwEfNUlyNY0yD+fy
         31wjpsuC0kG4opZKb06reKgkK4rkcN0cFWVUeLJvhUoQsA2agQ93TBT6XjgPuWNSQUr1
         +nbWDyxiUFxYayLsv/mi6lSupSNmqbuKcaD8FEhlSPoW0md8Ll8/snZEnbcQB7QZZ7mP
         gLI+p2bnkErskJ+hXkRwIubhQg/NPLbwh90memO05kMQDw6UKd0cUiO7Pil5cmEHlWDC
         fJ4g==
X-Gm-Message-State: AFqh2koyVTFTT+rQAmQqjcaPCJxq7uZScsL2NZ/tEI1oFmNrLIQKjNJ3
        f3Y3hJHFjTej3/J7YEa71/j5LLomU1ZGs8nXpH2SIhWpwmCDlg==
X-Google-Smtp-Source: AMrXdXv69ff6h3PEw35cc1vBZQg9QGdnwzJEqcRjoNu4u+N5EhYERF3DXAba0jyHjKVddch33Uqhv3xAFRCA7rFJX04=
X-Received: by 2002:a17:906:d790:b0:83e:cc7:27f with SMTP id
 pj16-20020a170906d79000b0083e0cc7027fmr2767211ejb.751.1672829647718; Wed, 04
 Jan 2023 02:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
In-Reply-To: <20230103-fstests-setgid-v6-2-v2-1-9c70ee2a4113@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Jan 2023 11:53:56 +0100
Message-ID: <CAJfpegvbcQ6QTJuAW8CRGd7Zm_K4nvQCixJgD-VkcNU3d7b4Qw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: update setgid tests
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 4 Jan 2023 at 11:09, Christian Brauner <brauner@kernel.org> wrote:
>
> Over mutiple kernel releases we have reworked setgid inheritance
> significantly due to long-standing security issues, security issues that
> were reintroduced after they were fixed, and the subtle and difficult
> inheritance rules that plagued individual filesystems. We have lifted
> setgid inheritance into the VFS proper in earlier patches. Starting with
> kernel v6.2 we have made setgid inheritance consistent between the write
> and setattr (ch{mod,own}) paths.
>
> The gist of the requirement is that in order to inherit the setgid bit
> the user needs to be in the group of the file or have CAP_FSETID in
> their user namespace. Otherwise the setgid bit will be dropped
> irregardless of the file's executability. Change the tests accordingly
> and annotate them with the commits that changed the behavior.
>
> Note, that only with v6.2 setgid inheritance works correctly for
> overlayfs in the write path. Before this the setgid bit was always
> retained.

Shouldn't the test ignore sgid without group execute instead?   It's
not a security issue and expecting a certain value is not going to
help find real issues (e.g. in old distro kernels, where this test
will now start failing).

Yeah, doing that is more involved, but I do believe that it would be
the right way to go.

Thanks,
Miklos
