Received: from mail-oi0-f53.google.com ([209.85.218.53]:35627 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdEPIQB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2017 04:16:01 -0400
Received: by mail-oi0-f53.google.com with SMTP id l18so16055592oig.2
        for <fstests@vger.kernel.org>; Tue, 16 May 2017 01:16:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494832679-13246-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1494832679-13246-1-git-send-email-yangx.jy@cn.fujitsu.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 May 2017 11:16:00 +0300
Message-ID: <CAOQ4uxjA05XO6xfG1AkpF69LkkQM-y5FrKia0pU-ztx8DaPgsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] common: use _require_xfs_io_command() directly to
 check fiemap
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, May 15, 2017 at 10:17 AM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> We could remove _require_fiemap and _require_fiemap_attr.
>

We COULD remove it but why SHOULD we?
