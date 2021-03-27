Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E8C433C1
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5784619F3
	for <linux-fstests@archiver.kernel.org>; Sat, 27 Mar 2021 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhC0L2L (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 27 Mar 2021 07:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhC0L2L (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Mar 2021 07:28:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06049619E8;
        Sat, 27 Mar 2021 11:28:08 +0000 (UTC)
Date:   Sat, 27 Mar 2021 12:28:06 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 0/6] fstests: add idmapped mounts tests
Message-ID: <20210327112806.usokw42evjvkcrfh@wittgenstein>
References: <20210327111856.1211544-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210327111856.1211544-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Mar 27, 2021 at 12:18:50PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Hey everyone,
> 
> This series is available from:
> https://git.kernel.org/brauner/xfstests-dev/h/idmapped_mounts
> https://gitlab.com/brauner/xfstests/-/tree/idmapped_mounts
> https://github.com/brauner/xfstests/tree/idmapped_mounts

The second patch does not (again because of size most likely or some
other vger issues) appear on the list. It can however be pulled from
above places.

Sorry for the inconvenience.
Thanks!
Christian
