Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24676C433ED
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 05:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C3C613AB
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Apr 2021 05:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhDTFyv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Apr 2021 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhDTFyv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Apr 2021 01:54:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336ADC061763
        for <fstests@vger.kernel.org>; Mon, 19 Apr 2021 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/SDmBCzuSKM8GUT+jIzGIKKauwAvgJvCrDg8BUqQWig=; b=o7NagaU3GzCrEu7DqUTUA+GKsK
        16a+3OimsCdJVoWj17oIgZyDhIxDBbMnu5N8pTcHVwEcn6rKchW4sWDYYlXEdGB1PCT2+PCS3iNHQ
        EWPUrFMLOIPzE/+r+2r+p6vHhzKDHv9GgCBwYEEeEVT8V8IYQ8EdIxTaQcr9p8qJ7dj+OlXX/3kWc
        Tvmmi7gOQCv5UtuAoa7h4vwE1rVFwYvK3YWh7lReflieLavgo6TPSVf38vYf3mM673ql8mtVEoUhB
        qLds9e0/3wZQnYNBxjFh4LH6qf9vKIjVqyXqHU67V2BWDWRft7SGOzuALnK+3CwpUn/wwt6AFfIgX
        fC7nOYvA==;
Received: from [2001:4bb8:19b:f845:7e4b:8a2:58e2:9b7b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYjL0-00BpSg-Ab
        for fstests@vger.kernel.org; Tue, 20 Apr 2021 05:54:18 +0000
Date:   Tue, 20 Apr 2021 07:54:16 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     fstests@vger.kernel.org
Subject: generic/095 and generic/300 failures
Message-ID: <YH5siAMU+6p7iD01@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi all,

generic/095 and generic/300 have been failing for me with every config
on every file system for a while with the following messages:

--- tests/generic/095.out	2016-03-29 13:59:30.405053956 +0000
+++ results/generic/095.out.bad	2021-04-20 05:44:54.432081845 +0000
@@ -1,2 +1,7 @@
 QA output created by 095
+job9: No I/O performed by mmap, perhaps try --debug=io option for details?
+job9: No I/O performed by mmap, perhaps try --debug=io option for details?
+job9: No I/O performed by mmap, perhaps try --debug=io option for details?
+job9: No I/O performed by mmap, perhaps try --debug=io option for details?
+job9: No I/O performed by mmap, perhaps try --debug=io option for details?
 Silence is golden           

--- tests/generic/300.out	2016-03-29 13:59:30.431720622 +0000
+++ results/generic/300.out.bad	2021-04-20 05:45:06.324708699 +0000
@@ -2,3 +2,4 @@
 
 Run fio with random aio-dio pattern
   
+falloc_raicer: No I/O performed by falloc, perhaps try --debug=io option for details?


----- End forwarded message -----
